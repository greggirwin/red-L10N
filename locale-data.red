Red []

; Here we can play with different structures, and note needed fields.

locales: #(
	default: #(
		ID:         #[none]		; https://unicode.org/reports/tr35/#Canonical_Unicode_Locale_Identifiers
		language:   #[none]
		script:     #[none]		; language, region, script/subculture could be combined.
								; just the lexical form and asking for one segment can parse that.
		country-code: #[none]
		variant-code: #[none]
		
		currencies: #[none]		; ??? Should this be in system/catalog, as read-only? system/locale/currencies/list currently.
		currency-code: #[none]	; 3 letter code
		days:       #[none]
		months:     #[none]
		date-time:  #[none]
		number:     #[none]
		rel-time:   #[none]
		plurals:    #[none]
		calendar:   #[none]
		collation:  #[none]	
	)
	en-EN: #(
	
	)
	fr-FR: #(
	
	)
)