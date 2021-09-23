Red []

; Here we can play with different structures, and note needed fields.

locales: #(
	default: #(
		ID:         #[none]		; https://unicode.org/reports/tr35/#Canonical_Unicode_Locale_Identifiers
		language:   #[none]
		script:     #[none]		; language, region, script/subculture could be combined.
								; just the lexical form and asking for one segment can parse that.
		currencies: #[none]		; ??? Should this be in system/catalog?
		days:       #[none]
		months:     #[none]
		date-time:  #[none]
		number:     #[none]
		rel-time:   #[none]
		plurals:    #[none]
		calendar:   #[none]
		
	)
	en-EN: #(
	
	)
	fr-FR: #(
	
	)
)