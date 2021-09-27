Red []

; Here we can play with different structures, and note needed fields.

;?? Do we want named formats to support blocks, as the dispatching uses
;	today, or should it only support masks? If we want to do things
;	like C-hex, we need logic for the conversion aspect. And for `[sci
;	eng acct]` there is also not a single defined mask.
;   Also, by using keys, we can only match exactly, where the current
;	code uses `switch` so there are fallthrough cases when more than
;	one key uses the same format. Another view is that those shouldn't
;	exist. `[sci  scientific]`, for example is nice, but will anyone 
;	use the long form?
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
		;?? Should days and months be keyed, or just ordered blocks?
		;?? How do we want to spec abbreviations?
		days:       ["Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday" "Sunday"]
		months:     [
		    "January" "February" "March" "April" "May" "June" 
		    "July" "August" "September" "October" "November" "December"
		]

;?? Should we have a `formats` section these all live under?
		date-time:  #[none]
		;number:     #[none]
		number:     #(
			;The 'r- prefix stands for "round-trip/Ren/Redbol"
			r-general  [add-seps/with n r-sep]	; #'##0.0#
			r-standard [add-seps/with n r-sep]	; #'##0.0#
			r-fixed    [add-seps/with format-number-by-width n 1 2 r-sep]  ; #'##0.00
			;r-currency [add-seps/with to money! n r-sep]                ; $#'##0.00
			;r-money    [add-seps/with to money! n r-sep]                ; $#'##0.00
			r-money	   [format-number-with-mask round/to n .01 "$#'###'###'###'##0.00"] ; $#'##0.00  -$#'##0.00
			r-currency [format-number-with-mask round/to n .01 "$#'###'###'###'##0.00"] ; $#'##0.00  -$#'##0.00
			;r-currency [add-seps/with round/to n .01 r-sep] ; $#'##0.00  -$#'##0.00
			r-percent  [add-seps/with format-number-by-width to percent! n 1 2 r-sep]			; format-number-by-width auto handles percent
			r-ordinal  [add-seps/with as-ordinal to integer! n r-sep]
			r-hex      [to-hex to integer! n]

			gen        [add-seps n]	; #,##0.0#
			general    [add-seps n]	; #,##0.0#
			standard [add-seps n]	; #,##0.0#
			
			fixed    [add-seps format-number-by-width n 1 2]          ; #,##0.00
			;currency [add-seps to money! n] ; $#,##0.00
			;money    [add-seps to money! n] ; $#,##0.00
			money    [format-number-with-mask round/to n .01 "$#,###,###,###,##0.00"] ; $#,##0.00
			currency [format-number-with-mask round/to n .01 "$#,###,###,###,##0.00"] ; $#,##0.00
			;currency [add-seps round/to n .01] ; $#,##0.00
			percent  [add-seps format-number-by-width to percent! n 1 2]
			;percent  [join add-seps next form to money! value * 100 #"%"]
			
			sci			[form-num-ex/type n 'sci]
			scientific  [form-num-ex/type n 'sci]
			
			eng			[form-num-ex/type n 'eng]
			engineering [form-num-ex/type n 'eng]
			
			acct		[add-seps form-num-ex/type n 'acct]
			accounting  [add-seps form-num-ex/type n 'acct]
			;accounting [format-number-via-masks n [pos " #,##0.00 " neg "(#,##0.00)" zero "-" none ""]]
			
			ordinal  [add-seps as-ordinal to integer! n]

			base-64  [enbase/base form n 64]
			hex      [form to-hex to integer! n]
			min-hex  [							; No leading zeros
				either zero? n [""] [
					find form to-hex to integer! n complement charset "0"]	; No leading zeros
				]
			C-hex    [join "0x" to-hex to integer! n]
			;VB-hex   [join "&H" to-hex to integer! n]
			;octal    [] ; maybe useful for things like `chmod 755` viz	; no enbase for octal yet
			
			bin		[num-to-bin-str n]
			binary [num-to-bin-str n]
			
			min-bin  [							; No leading zeros
				either zero? n [""] [
					form find num-to-bin-str n complement charset "0"
				]
			]
		)
		rel-time:   #(
			;rel-days   [num-to-rel-date-time n 'rel-days]
			;rel-hours  [num-to-rel-date-time n 'rel-hours]
			;rel-time   [num-to-rel-date-time n 'rel-time]
			; throw error - unknown named format specified?
			;case else [either any-block? value [reform n] [form n]]
		)
		plurals:    #[none]
		calendar:   #[none]
		collation:  #[none]	
	)
	en-EN: #(
	
	)
;?? The only difference when formatting money (from numbers) is the mask.
;	The rest of the logic will remain the same. There are locales where
;	that's not the case however: https://en.wikipedia.org/wiki/ISO_4217
;	Because the number of decimal places is not 2.
	fr-FR: #(
		ID:         #[none]		; https://unicode.org/reports/tr35/#Canonical_Unicode_Locale_Identifiers
		language:   #[none]
		script:     #[none]		; language, region, script/subculture could be combined.
								; just the lexical form and asking for one segment can parse that.
		country-code: #[none]
		variant-code: #[none]
		
		currencies: #[none]		; ??? Should this be in system/catalog, as read-only? system/locale/currencies/list currently.
		currency-code: EUR
		;?? Should days and months be keyed, or just ordered blocks?
		days:       #[none]
		months:     #[none]
		number:     #(
			money    [format-number-with-mask round/to n .01 "# ### ### ### ##0,00 €"] ; $#,##0.00
			currency [format-number-with-mask round/to n .01 "# ### ### ### ##0,00 €"] ; $#,##0.00

			percent  [add-seps format-number-by-width to percent! n 1 2] ; FR uses a space before `%`
		)
	
	)
		ID:         #[none]		; https://unicode.org/reports/tr35/#Canonical_Unicode_Locale_Identifiers
		language:   #[none]
		script:     #[none]		; language, region, script/subculture could be combined.
								; just the lexical form and asking for one segment can parse that.
		country-code: #[none]
		variant-code: #[none]
		
		currencies: #[none]		; ??? Should this be in system/catalog, as read-only? system/locale/currencies/list currently.
		currency-code: #[none]	; 3 letter code
		;?? Should days and months be keyed, or just ordered blocks?
		days:       #[none]
		months:     #[none]
	de-DE: #(
		ID:         #[none]		; https://unicode.org/reports/tr35/#Canonical_Unicode_Locale_Identifiers
		language:   #[none]
		script:     #[none]		; language, region, script/subculture could be combined.
								; just the lexical form and asking for one segment can parse that.
		country-code: #[none]
		variant-code: #[none]
		
		currencies: #[none]		; ??? Should this be in system/catalog, as read-only? system/locale/currencies/list currently.
		currency-code: EUR
		;?? Should days and months be keyed, or just ordered blocks?
		days:       #[none]
		months:     #[none]

		number:     #(
			money    [format-number-with-mask round/to n .01 "#.###.###.###.##0,00 €"] ; $#,##0.00
			currency [format-number-with-mask round/to n .01 "#.###.###.###.##0,00 €"] ; $#,##0.00
		)
	
	)
)