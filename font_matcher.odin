package android

foreign import android "system:android"

/**
 * @file font_matcher.h
 * @brief Provides the font matching logic with various inputs.
 *
 * You can use this class for deciding what font is to be used for drawing text.
 *
 * A matcher is created from text style, locales and UI compatibility. The match function for
 * matcher object can be called multiple times until close function is called.
 *
 * Even if no font can render the given text, the match function will return a non-null result for
 * drawing Tofu character.
 *
 * Examples:
 * \code{.cpp}
 *  // Simple font query for the ASCII character.
 *  std::vector<uint16_t> text = { 'A' };
 *  AFontMatcher* matcher = AFontMatcher_create("sans-serif");
 *  AFont* font = AFontMatcher_match(text.data(), text.length(), &runLength);
 *  // runLength will be 1 and the font will points a valid font file.
 *  AFontMatcher_destroy(matcher);
 *
 *  // Querying font for CJK characters
 *  std::vector<uint16_t> text = { 0x9AA8 };
 *  AFontMatcher* matcher = AFontMatcher_create("sans-serif");
 *  AFontMatcher_setLocales(matcher, "zh-CN,ja-JP");
 *  AFont* font = AFontMatcher_match(text.data(), text.length(), &runLength);
 *  // runLength will be 1 and the font will points a Simplified Chinese font.
 *  AFontMatcher_setLocales(matcher, "ja-JP,zh-CN");
 *  AFont* font = AFontMatcher_match(text.data(), text.length(), &runLength);
 *  // runLength will be 1 and the font will points a Japanese font.
 *  AFontMatcher_destroy(matcher);
 *
 *  // Querying font for text/color emoji
 *  std::vector<uint16_t> text = { 0xD83D, 0xDC68, 0x200D, 0x2764, 0xFE0F, 0x200D, 0xD83D, 0xDC68 };
 *  AFontMatcher* matcher = AFontMatcher_create("sans-serif");
 *  AFont* font = AFontMatcher_match(text.data(), text.length(), &runLength);
 *  // runLength will be 8 and the font will points a color emoji font.
 *  AFontMatcher_destroy(matcher);
 *
 *  // Mixture of multiple script of characters.
 *  // 0x05D0 is a Hebrew character and 0x0E01 is a Thai character.
 *  std::vector<uint16_t> text = { 0x05D0, 0x0E01 };
 *  AFontMatcher* matcher = AFontMatcher_create("sans-serif");
 *  AFont* font = AFontMatcher_match(text.data(), text.length(), &runLength);
 *  // runLength will be 1 and the font will points a Hebrew font.
 *  AFontMatcher_destroy(matcher);
 * \endcode
 *
 * Available since API level 29.
 */

FamilyVariant :: enum u32 {
    /** A family variant value for the system default variant. */
    DEFAULT = 0,

    /**
     * A family variant value for the compact font family variant.
     *
     * The compact font family has Latin-based vertical metrics.
     */
    COMPACT = 1,

    /**
     * A family variant value for the elegant font family variant.
     *
     * The elegant font family may have larger vertical metrics than Latin font.
     */
    ELEGANT = 2,
};

/**
 * AFontMatcher performs match operation on given parameters and available font files.
 * This matcher is not a thread-safe object. Do not pass this matcher to other threads.
 */
AFontMatcher :: struct{}


foreign android {
	/**
	 * Creates a new AFontMatcher object.
	 *
	 * Available since API level 29.
	 */
	AFontMatcher_create :: proc() -> ^AFontMatcher ---

	/**
	* Destroy the matcher object.
	*
	* Available since API level 29.
	*
	* \param matcher a matcher object. Passing NULL is not allowed.
	*/
	AFontMatcher_destroy :: proc(matcher: ^AFontMatcher) ---

	/**
	* Set font style to matcher.
	*
	* If this function is not called, the matcher performs with {@link AFONT_WEIGHT_NORMAL}
	* with non-italic style.
	*
	* Available since API level 29.
	*
	* \param matcher a matcher object. Passing NULL is not allowed.
	* \param weight a font weight value. Only from 0 to 1000 value is valid
	* \param italic true if italic, otherwise false.
	*/
	AFontMatcher_setStyle :: proc(matcher: ^AFontMatcher, weight: FontWeight, italic: bool) ---

	/**
	* Set font locales to matcher.
	*
	* If this function is not called, the matcher performs with empty locale list.
	*
	* Available since API level 29.
	*
	* \param matcher a matcher object. Passing NULL is not allowed.
	* \param languageTags a null character terminated comma separated IETF BCP47 compliant language
	*                     tags.
	*/
	AFontMatcher_setLocales :: proc(matcher: ^AFontMatcher, languageTags: cstring) ---

	/**
	* Set family variant to matcher.
	*
	* If this function is not called, the matcher performs with {@link AFAMILY_VARIANT_DEFAULT}.
	*
	* Available since API level 29.
	*
	* \param matcher a matcher object. Passing NULL is not allowed.
	* \param familyVariant Must be one of {@link AFAMILY_VARIANT_DEFAULT},
	*                      {@link AFAMILY_VARIANT_COMPACT} or {@link AFAMILY_VARIANT_ELEGANT} is valid.
	*/
	AFontMatcher_setFamilyVariant :: proc(matcher: ^AFontMatcher, familyVariant: FamilyVariant) ---

	/**
	* Performs the matching from the generic font family for the text and select one font.
	*
	* For more information about generic font families, read [W3C spec](https://www.w3.org/TR/css-fonts-4/#generic-font-families)
	*
	* Even if no font can render the given text, this function will return a non-null result for
	* drawing Tofu character.
	*
	* Available since API level 29.
	*
	* \param matcher a matcher object. Passing NULL is not allowed.
	* \param familyName a null character terminated font family name
	* \param text a UTF-16 encoded text buffer to be rendered. Do not pass empty string.
	* \param textLength a length of the given text buffer. This must not be zero.
	* \param runLengthOut if not null, the font run length will be filled.
	* \return a font to be used for given text and params. You need to release the returned font by
	*         AFont_close when it is no longer needed.
	*/
	AFontMatcher_match :: proc(matcher: ^AFontMatcher, familyName: cstring, text: [^]u16, textLength: u32, runLengthOut: ^u32) -> ^AFont ---
}
