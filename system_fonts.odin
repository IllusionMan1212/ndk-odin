//+build android
package android

foreign import android "system:android"

/**
 * @file system_fonts.h
 * @brief Provides the system font configurations.
 *
 * These APIs provides the list of system installed font files with additional metadata about the
 * font.
 *
 * The ASystemFontIterator_open method will give you an iterator which can iterate all system
 * installed font files as shown in the following example.
 *
 * \code{.cpp}
 *   ASystemFontIterator* iterator = ASystemFontIterator_open();
 *   ASystemFont* font = NULL;
 *
 *   while ((font = ASystemFontIterator_next(iterator)) != nullptr) {
 *       // Look if the font is your desired one.
 *       if (ASystemFont_getWeight(font) == 400 && !ASystemFont_isItalic(font)
 *           && ASystemFont_getLocale(font) == NULL) {
 *           break;
 *       }
 *       ASystemFont_close(font);
 *   }
 *   ASystemFontIterator_close(iterator);
 *
 *   int fd = open(ASystemFont_getFontFilePath(font), O_RDONLY);
 *   int collectionIndex = ASystemFont_getCollectionINdex(font);
 *   std::vector<std::pair<uint32_t, float>> variationSettings;
 *   for (size_t i = 0; i < ASystemFont_getAxisCount(font); ++i) {
 *       variationSettings.push_back(std::make_pair(
 *           ASystemFont_getAxisTag(font, i),
 *           ASystemFont_getAxisValue(font, i)));
 *   }
 *   ASystemFont_close(font);
 *
 *   // Use this font for your text rendering engine.
 *
 * \endcode
 *
 * Available since API level 29.
 */

/**
 * ASystemFontIterator provides access to the system font configuration.
 *
 * ASystemFontIterator is an iterator for all available system font settings.
 * This iterator is not a thread-safe object. Do not pass this iterator to other threads.
 */
ASystemFontIterator :: struct{}

foreign android {
	/**
	 * Create a system font iterator.
	 *
	 * Use ASystemFont_close() to close the iterator.
	 *
	 * Available since API level 29.
	 *
	 * \return a pointer for a newly allocated iterator, nullptr on failure.
	 */
	ASystemFontIterator_open :: proc() -> ^ASystemFontIterator ---

	/**
	* Close an opened system font iterator, freeing any related resources.
	*
	* Available since API level 29.
	*
	* \param iterator a pointer of an iterator for the system fonts. Do nothing if NULL is passed.
	*/
	ASystemFontIterator_close :: proc(iterator: ^ASystemFontIterator) ---

	/**
	* Move to the next system font.
	*
	* Available since API level 29.
	*
	* \param iterator an iterator for the system fonts. Passing NULL is not allowed.
	* \return a font. If no more font is available, returns nullptr. You need to release the returned
	*         font by ASystemFont_close when it is no longer needed.
	*/
	ASystemFontIterator_next :: proc(iterator: ^ASystemFontIterator) -> ^AFont ---
}
