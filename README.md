# red-L10N
L10N R&amp;D for Red

I18N / G11N is the planning and architecture aspect.
L10N is the active work of translating elements.

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
- https://unicode-org.github.io/icu/userguide/locale/
- https://unicode-org.github.io/icu/userguide/locale/resources
- https://unicode-org.github.io/icu/userguide/datetime/

- https://github.com/tc39/ecma402

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
