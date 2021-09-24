# red-L10N
L10N R&amp;D for Red

I18N is the planning and architecture aspect.

L10N is the active work of translating elements.

G11N is I18N + L10N

# Questions

1. What do we get from each platform to tell is the user's locale setting?

2. What does our locale data model look like? This, I think, ties directly
   to hierarchical environments, merging structures. It doesn't mean they
   have to be physically merged into one, but there is the concept of
   scoping when values are looked up.
   
   tr35> There are actually two different kinds of inheritance fallback: 
   resource bundle lookup and resource item lookup. For the former, a
   process is looking to find the first, best resource bundle it can;
   for the later, it is fallback within bundles on individual items
   
   - https://unicode.org/reports/tr35/#Bundle_vs_Item_Lookup
   - https://unicode.org/reports/tr35/#LanguageMatching
   - TR35 talks about this a lot more, with examples
     https://unicode.org/reports/tr35/#Resolved_Data_File
     
   For our initial purposes, we can just do exact matching, but still
   need to fall back to a default locale when needed. 
   
   Locale fallback proceeds as follows:

    The variant is removed, if there is one.

    The country is removed, if there is one.

    The script is removed, if there is one.

    The ICU default locale is examined. The same set of steps is
    performed for the default locale.
   
     
3. Which functions and other aspects of Red are locale sensitive?

4. What does localized content look like in a script or app? That is, what
   are the keys, do we set a locale at the top, or at runtime, and only
   overrides are needed, and everything else is declarative, or are L10N
   calls strewn throughout? This is the I18N aspect.
   
5. Are there standards we should or must follow? So much work has been 
   done in this area, and there seems to be at least a rough consensus
   on many aspects, that it makes sense to keep them in mind. But we
   should still simplify things and make it as data oriented as possible.
   
   Locale IDs are most important here, starting with the basics. unicode.org
   has a bazillion details we won't include.
   
   - https://unicode.org/reports/tr35/#Canonical_Unicode_Locale_Identifiers
   - BCP 47
   - https://unicode-org.github.io/icu/userguide/locale/resources.html
   
6. What does our API to the L10N system look like?

7. What are the security risks in the system? How do we protect locale data
   from being changed, potentially with executable code. The other view 
   being, how do we ensure locale data is never itself evaluated. Think
   compound messages, or the model many systems use where you use the L10N
   system to get `*-formatter` objects.

# Thoughts

All the indirection and layering for resource bundles and APIs to access
the elements in them can impose constraints in a useful way. But what it
seems they really do is just complicate the fact that this is all data,
and items need to be looked up by some kind of key.

Another bit is that the ability to fall back to other locales is vital.
A tree structure makes sense here, but that doesn't mean we have to write
the data as nested structures. We don't want to call it inheritance, but
that's sort of what it is.

Some excecutable logic may be necessary, but I don't *think* we want to
think in terms of `formatter` objects. We want a general formatting system
that dovetails nicely with the data model, to reduce friction and make data
clear and easily separated. That said, not every app needs complete L10N
throughout. 

The plurals aspect in the standards all seem to think in terms of integers.
There is no concept of time ranges, for relative times.It seems like
https://tc39.es/ecma402/#relativetimeformat-objects should address it, but
they've hidden any useful details in a morass of "let x be y" statements.

# References

RFC 4646
ISO 639
ISO 3166
BCP 47      https://tools.ietf.org/html/bcp47
ISO 639-2
ISO 15924   ; includes script code

en-US = language-code/region-code-2  region-code-2 = subculture

A neutral culture is specified by only the two-letter, lowercase language
code. For example, fr specifies the neutral culture for French. There are
two culture names that contradict this rule. The cultures Chinese
(Simplified), named zh-Hans, and Chinese (Traditional), named zh-Hant,
are neutral cultures.


- https://github.com/red/red/wiki/%5BHOWTO%5D-Windows-Locale-Handling

- https://www.javacodegeeks.com/2013/02/internationalization-vs-localization-i18n-vs-l10n.html

- https://docs.microsoft.com/en-us/dotnet/api/system.globalization.cultureinfo?view=net-5.0
  culture = locale = language, sublanguage, country/region, calendar, and conventions
  i.e. Windows now calls `locale` `culture`.
  
- https://unicode-org.github.io/icu/userguide/format_parse/messages/
  - https://formatjs.io/docs/core-concepts/icu-syntax/
    - https://formatjs.io/docs/core-concepts/icu-syntax#plural-format
    - https://formatjs.io/docs/core-concepts/icu-syntax#selectordinal-format
- https://unicode-org.github.io/icu/userguide/locale/
- https://unicode-org.github.io/icu/userguide/locale/resources
- https://unicode-org.github.io/icu/userguide/datetime/

- https://tc39.es/ecma402/ comes from https://github.com/tc39/ecma402
  - https://tc39.es/ecma402/#normative-references
  
- https://formatjs.io/
- https://formatjs.io/docs/getting-started/application-workflow
- https://github.com/formatjs/formatjs#change-how-messages-are-formatted

- https://docs.oracle.com/javase/tutorial/i18n/intro/index.html
- https://docs.oracle.com/javase/tutorial/i18n/intro/checklist.html

    currentLocale = new Locale(language, country);
    messages: ResourceBundle.getBundle(ID, locale)
    print messages.getString("greetings")
    
    - bundles are property files of key-value pairs
    - They call interpolated messages "compound messages"
      - https://docs.oracle.com/javase/tutorial/i18n/format/messageintro.html
      - https://docs.oracle.com/javase/tutorial/i18n/format/messageFormat.html
      - https://docs.oracle.com/javase/tutorial/i18n/format/choiceFormat.html
      
    - https://docs.oracle.com/javase/tutorial/i18n/format/numberintro.html
    
      In their masks, comma is always the group sep and period always the
      decimal sep. But they have `applyLocalizedPattern` for when the mask
      is exposed directly to users.
      
      https://docs.oracle.com/javase/tutorial/i18n/format/decimalFormat.html
      has their table of special chars for patterns.
    
    - https://docs.oracle.com/javase/tutorial/i18n/format/dateintro.html
      
      Pattern chars are opaque. G, k, etc. Not human friendly.
      
      Special symbols are changed with setters on the date class.
      -https://docs.oracle.com/javase/tutorial/i18n/format/dateFormatSymbols.html
      
- https://medium.com/i18n-and-l10n-resources-for-developers/tagged/java


- https://docs.microsoft.com/en-us/dotnet/api/system.globalization?view=net-5.0

- https://docs.microsoft.com/en-us/aspnet/core/fundamentals/localization?view=aspnetcore-5.0

  IStringLocalizer, ResourceManager, ResourceReader
  
  - https://docs.microsoft.com/en-us/dotnet/api/system.globalization.cultureinfo?view=net-5.0#culture-and-task-based-asynchronous-operations
  Gaaaaahhhh! Service request locales never occurred to me.  

- https://swiftpackageregistry.com/Decybel07/L10n-swift

  Uses func args to denote properties, rather than masks. e.g. `minIntegerDigits`,
  and `fractionDigits`.
  
  Supports structure/paths in resources.

- https://developer.apple.com/documentation/xcode/localization

- https://medium.com/i18n-and-l10n-resources-for-developers/ios-tutorial-on-internationalization-and-localization-20ed3e9d53e3
  Good for a look at how XCode/iOS works, from a resource editing standpoint.
  
  
  Also attributes for resources by platform.
  
- https://phrase.com/features/developers/
- https://help.phrase.com/help/react-intl-simple-json
- https://lokalise.com/blog/i18n-internationalization-l10n-localization-developer-tutorials/

# Types

## Numbers and Currency

## Date-Time

TimeZone names - IANA Time Zone Database

## Strings and Messages

## Units and Unit Identifiers

