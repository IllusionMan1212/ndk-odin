//+build android
package android

foreign import android "system:android"

FontWeight :: enum u16 {
    /** The minimum value fot the font weight value. */
    MIN = 0,

    /** A font weight value for the thin weight. */
    THIN = 100,

    /** A font weight value for the extra-light weight. */
    EXTRA_LIGHT = 200,

    /** A font weight value for the light weight. */
    LIGHT = 300,

    /** A font weight value for the normal weight. */
    NORMAL = 400,

    /** A font weight value for the medium weight. */
    MEDIUM = 500,

    /** A font weight value for the semi-bold weight. */
    SEMI_BOLD = 600,

    /** A font weight value for the bold weight. */
    BOLD = 700,

    /** A font weight value for the extra-bold weight. */
    EXTRA_BOLD = 800,

    /** A font weight value for the black weight. */
    BLACK = 900,

    /** The maximum value for the font weight value. */
    MAX = 1000
}

/**
 * AFont provides information of the single font configuration.
 */
AFont :: struct{}


foreign android {
	/**
	 * Close an AFont.
	 *
	 * Available since API level 29.
	 *
	 * \param font a font returned by ASystemFontIterator_next or AFontMatchert_match.
	 *        Do nothing if NULL is passed.
	 */
	 AFont_close :: proc(font: ^AFont) ---

	/**
	* Return an absolute path to the current font file.
	*
	* Here is a list of font formats returned by this method:
	* <ul>
	*   <li>OpenType</li>
	*   <li>OpenType Font Collection</li>
	*   <li>TrueType</li>
	*   <li>TrueType Collection</li>
	* </ul>
	* The file extension could be one of *.otf, *.ttf, *.otc or *.ttc.
	*
	* The font file returned is guaranteed to be opend with O_RDONLY.
	* Note that the returned pointer is valid until AFont_close() is called for the given font.
	*
	* Available since API level 29.
	*
	* \param font a font object. Passing NULL is not allowed.
	* \return a string of the font file path.
	*/
	AFont_getFontFilePath :: proc(font: ^AFont) -> cstring ---

	/**
	* Return a weight value associated with the current font.
	*
	* The weight values are positive and less than or equal to 1000.
	* Here are pairs of the common names and their values.
	* <p>
	*  <table>
	*  <tr>
	*  <th align="center">Value</th>
	*  <th align="center">Name</th>
	*  <th align="center">NDK Definition</th>
	*  </tr>
	*  <tr>
	*  <td align="center">100</td>
	*  <td align="center">Thin</td>
	*  <td align="center">{@link AFONT_WEIGHT_THIN}</td>
	*  </tr>
	*  <tr>
	*  <td align="center">200</td>
	*  <td align="center">Extra Light (Ultra Light)</td>
	*  <td align="center">{@link AFONT_WEIGHT_EXTRA_LIGHT}</td>
	*  </tr>
	*  <tr>
	*  <td align="center">300</td>
	*  <td align="center">Light</td>
	*  <td align="center">{@link AFONT_WEIGHT_LIGHT}</td>
	*  </tr>
	*  <tr>
	*  <td align="center">400</td>
	*  <td align="center">Normal (Regular)</td>
	*  <td align="center">{@link AFONT_WEIGHT_NORMAL}</td>
	*  </tr>
	*  <tr>
	*  <td align="center">500</td>
	*  <td align="center">Medium</td>
	*  <td align="center">{@link AFONT_WEIGHT_MEDIUM}</td>
	*  </tr>
	*  <tr>
	*  <td align="center">600</td>
	*  <td align="center">Semi Bold (Demi Bold)</td>
	*  <td align="center">{@link AFONT_WEIGHT_SEMI_BOLD}</td>
	*  </tr>
	*  <tr>
	*  <td align="center">700</td>
	*  <td align="center">Bold</td>
	*  <td align="center">{@link AFONT_WEIGHT_BOLD}</td>
	*  </tr>
	*  <tr>
	*  <td align="center">800</td>
	*  <td align="center">Extra Bold (Ultra Bold)</td>
	*  <td align="center">{@link AFONT_WEIGHT_EXTRA_BOLD}</td>
	*  </tr>
	*  <tr>
	*  <td align="center">900</td>
	*  <td align="center">Black (Heavy)</td>
	*  <td align="center">{@link AFONT_WEIGHT_BLACK}</td>
	*  </tr>
	*  </table>
	* </p>
	* Note that the weight value may fall in between above values, e.g. 250 weight.
	*
	* For more information about font weight, read [OpenType usWeightClass](https://docs.microsoft.com/en-us/typography/opentype/spec/os2#usweightclass)
	*
	* Available since API level 29.
	*
	* \param font a font object. Passing NULL is not allowed.
	* \return a positive integer less than or equal to {@link AFONT_WEIGHT_MAX} is returned.
	*/
	AFont_getWeight :: proc(font: ^AFont) -> FontWeight ---

	/**
	* Return true if the current font is italic, otherwise returns false.
	*
	* Available since API level 29.
	*
	* \param font a font object. Passing NULL is not allowed.
	* \return true if italic, otherwise false.
	*/
	AFont_isItalic :: proc(font: ^AFont) -> bool ---

	/**
	* Return a IETF BCP47 compliant language tag associated with the current font.
	*
	* For information about IETF BCP47, read [Locale.forLanguageTag(java.lang.String)](https://developer.android.com/reference/java/util/Locale.html#forLanguageTag(java.lang.String)")
	*
	* Note that the returned pointer is valid until AFont_close() is called.
	*
	* Available since API level 29.
	*
	* \param font a font object. Passing NULL is not allowed.
	* \return a IETF BCP47 compliant language tag or nullptr if not available.
	*/
	AFont_getLocale :: proc(font: ^AFont) -> cstring ---

	/**
	* Return a font collection index value associated with the current font.
	*
	* In case the target font file is a font collection (e.g. .ttc or .otc), this
	* returns a non-negative value as an font offset in the collection. This
	* always returns 0 if the target font file is a regular font.
	*
	* Available since API level 29.
	*
	* \param font a font object. Passing NULL is not allowed.
	* \return a font collection index.
	*/
	AFont_getCollectionIndex :: proc(font: ^AFont) -> uint ---

	/**
	* Return a count of font variation settings associated with the current font
	*
	* The font variation settings are provided as multiple tag-values pairs.
	*
	* For example, bold italic font may have following font variation settings:
	*     'wght' 700, 'slnt' -12
	* In this case, AFont_getAxisCount returns 2 and AFont_getAxisTag
	* and AFont_getAxisValue will return following values.
	* \code{.cpp}
	*     AFont* font = ASystemFontIterator_next(ite)
	*
	*     // Returns the number of axes
	*     AFont_getAxisCount(font)  // Returns 2
	*
	*     // Returns the tag-value pair for the first axis.
	*     AFont_getAxisTag(font, 0)  // Returns 'wght'(0x77676874)
	*     AFont_getAxisValue(font, 0)  // Returns 700.0
	*
	*     // Returns the tag-value pair for the second axis.
	*     AFont_getAxisTag(font, 1)  // Returns 'slnt'(0x736c6e74)
	*     AFont_getAxisValue(font, 1)  // Returns -12.0
	* \endcode
	*
	* For more information about font variation settings, read [Font Variations Table](https://docs.microsoft.com/en-us/typography/opentype/spec/fvar)
	*
	* Available since API level 29.
	*
	* \param font a font object. Passing NULL is not allowed.
	* \return a number of font variation settings.
	*/
	AFont_getAxisCount :: proc(font: ^AFont) -> uint ---


	/**
	* Return an OpenType axis tag associated with the current font.
	*
	* See AFont_getAxisCount for more details.
	*
	* Available since API level 29.
	*
	* \param font a font object. Passing NULL is not allowed.
	* \param axisIndex an index to the font variation settings. Passing value larger than or
	*        equal to {@link AFont_getAxisCount} is not allowed.
	* \return an OpenType axis tag value for the given font variation setting.
	*/
	AFont_getAxisTag :: proc(font: ^AFont, axisIndex: u32) -> u32 ---

	/**
	* Return an OpenType axis value associated with the current font.
	*
	* See AFont_getAxisCount for more details.
	*
	* Available since API level 29.
	*
	* \param font a font object. Passing NULL is not allowed.
	* \param axisIndex an index to the font variation settings. Passing value larger than or
	*         equal to {@link AFont_getAxisCount} is not allowed.
	* \return a float value for the given font variation setting.
	*/
	AFont_getAxisValue :: proc(font: ^AFont, axisIndex: u32) -> f32 ---
}
