//+build android
package android

foreign import android "system:android"

/** Orientation: not specified. */
ORIENTATION_ANY  :: 0x0000
/**
* Orientation: value corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#OrientationQualifier">port</a>
* resource qualifier.
*/
ORIENTATION_PORT :: 0x0001
/**
* Orientation: value corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#OrientationQualifier">land</a>
* resource qualifier.
*/
ORIENTATION_LAND :: 0x0002
/** @deprecated Not currently supported or used. */
ORIENTATION_SQUARE :: 0x0003

/** Touchscreen: not specified. */
TOUCHSCREEN_ANY  :: 0x0000
/**
* Touchscreen: value corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#TouchscreenQualifier">notouch</a>
* resource qualifier.
*/
TOUCHSCREEN_NOTOUCH  :: 0x0001
/** @deprecated Not currently supported or used. */
TOUCHSCREEN_STYLUS  :: 0x0002
/**
* Touchscreen: value corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#TouchscreenQualifier">finger</a>
* resource qualifier.
*/
TOUCHSCREEN_FINGER  :: 0x0003

/** Density: default density. */
DENSITY_DEFAULT :: 0
/**
* Density: value corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#DensityQualifier">ldpi</a>
* resource qualifier.
*/
DENSITY_LOW :: 120
/**
* Density: value corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#DensityQualifier">mdpi</a>
* resource qualifier.
*/
DENSITY_MEDIUM :: 160
/**
* Density: value corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#DensityQualifier">tvdpi</a>
* resource qualifier.
*/
DENSITY_TV :: 213
/**
* Density: value corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#DensityQualifier">hdpi</a>
* resource qualifier.
*/
DENSITY_HIGH :: 240
/**
* Density: value corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#DensityQualifier">xhdpi</a>
* resource qualifier.
*/
DENSITY_XHIGH :: 320
/**
* Density: value corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#DensityQualifier">xxhdpi</a>
* resource qualifier.
*/
DENSITY_XXHIGH :: 480
/**
* Density: value corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#DensityQualifier">xxxhdpi</a>
* resource qualifier.
*/
DENSITY_XXXHIGH :: 640
/** Density: any density. */
DENSITY_ANY :: 0xfffe
/** Density: no density specified. */
DENSITY_NONE :: 0xffff

/** Keyboard: not specified. */
KEYBOARD_ANY  :: 0x0000
/**
* Keyboard: value corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#ImeQualifier">nokeys</a>
* resource qualifier.
*/
KEYBOARD_NOKEYS  :: 0x0001
/**
* Keyboard: value corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#ImeQualifier">qwerty</a>
* resource qualifier.
*/
KEYBOARD_QWERTY  :: 0x0002
/**
* Keyboard: value corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#ImeQualifier">12key</a>
* resource qualifier.
*/
KEYBOARD_12KEY  :: 0x0003

/** Navigation: not specified. */
NAVIGATION_ANY  :: 0x0000
/**
* Navigation: value corresponding to the
* <a href::"@/guide/topics/resources/providing-resources.html#NavigationQualifier">nonav</a>
* resource qualifier.
*/
NAVIGATION_NONAV  :: 0x0001
/**
* Navigation: value corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#NavigationQualifier">dpad</a>
* resource qualifier.
*/
NAVIGATION_DPAD  :: 0x0002
/**
* Navigation: value corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#NavigationQualifier">trackball</a>
* resource qualifier.
*/
NAVIGATION_TRACKBALL  :: 0x0003
/**
* Navigation: value corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#NavigationQualifier">wheel</a>
* resource qualifier.
*/
NAVIGATION_WHEEL  :: 0x0004

/** Keyboard availability: not specified. */
KEYSHIDDEN_ANY :: 0x0000
/**
* Keyboard availability: value corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#KeyboardAvailQualifier">keysexposed</a>
* resource qualifier.
*/
KEYSHIDDEN_NO :: 0x0001
/**
* Keyboard availability: value corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#KeyboardAvailQualifier">keyshidden</a>
* resource qualifier.
*/
KEYSHIDDEN_YES :: 0x0002
/**
* Keyboard availability: value corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#KeyboardAvailQualifier">keyssoft</a>
* resource qualifier.
*/
KEYSHIDDEN_SOFT :: 0x0003

/** Navigation availability: not specified. */
NAVHIDDEN_ANY :: 0x0000
/**
* Navigation availability: value corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#NavAvailQualifier">navexposed</a>
* resource qualifier.
*/
NAVHIDDEN_NO :: 0x0001
/**
* Navigation availability: value corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#NavAvailQualifier">navhidden</a>
* resource qualifier.
*/
NAVHIDDEN_YES :: 0x0002

/** Screen size: not specified. */
SCREENSIZE_ANY  :: 0x00
/**
* Screen size: value indicating the screen is at least
* approximately 320x426 dp units corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#ScreenSizeQualifier">small</a>
* resource qualifier.
*/
SCREENSIZE_SMALL :: 0x01
/**
* Screen size: value indicating the screen is at least
* approximately 320x470 dp units corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#ScreenSizeQualifier">normal</a>
* resource qualifier.
*/
SCREENSIZE_NORMAL :: 0x02
/**
* Screen size: value indicating the screen is at least
* approximately 480x640 dp units corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#ScreenSizeQualifier">large</a>
* resource qualifier.
*/
SCREENSIZE_LARGE :: 0x03
/**
* Screen size: value indicating the screen is at least
* approximately 720x960 dp units corresponding to the
* <a href::"/guide/topics/resources/providing-resources.html#ScreenSizeQualifier">xlarge</a>
* resource qualifier.
*/
SCREENSIZE_XLARGE :: 0x04

/** Screen layout: not specified. */
SCREENLONG_ANY :: 0x00
/**
* Screen layout: value that corresponds to the
* <a href::"/guide/topics/resources/providing-resources.html#ScreenAspectQualifier">notlong</a>
* resource qualifier.
*/
SCREENLONG_NO :: 0x1
/**
* Screen layout: value that corresponds to the
* <a href::"/guide/topics/resources/providing-resources.html#ScreenAspectQualifier">long</a>
* resource qualifier.
*/
SCREENLONG_YES :: 0x2

SCREENROUND_ANY :: 0x00
SCREENROUND_NO :: 0x1
SCREENROUND_YES :: 0x2

/** Wide color gamut: not specified. */
WIDE_COLOR_GAMUT_ANY :: 0x00
/**
* Wide color gamut: value that corresponds to
* <a href::"/guide/topics/resources/providing-resources.html#WideColorGamutQualifier">no
* nowidecg</a> resource qualifier specified.
*/
WIDE_COLOR_GAMUT_NO :: 0x1
/**
* Wide color gamut: value that corresponds to
* <a href::"/guide/topics/resources/providing-resources.html#WideColorGamutQualifier">
* widecg</a> resource qualifier specified.
*/
WIDE_COLOR_GAMUT_YES :: 0x2

/** HDR: not specified. */
HDR_ANY :: 0x00
/**
* HDR: value that corresponds to
* <a href::"/guide/topics/resources/providing-resources.html#HDRQualifier">
* lowdr</a> resource qualifier specified.
*/
HDR_NO :: 0x1
/**
* HDR: value that corresponds to
* <a href::"/guide/topics/resources/providing-resources.html#HDRQualifier">
* highdr</a> resource qualifier specified.
*/
HDR_YES :: 0x2

/** UI mode: not specified. */
UI_MODE_TYPE_ANY :: 0x00
/**
* UI mode: value that corresponds to
* <a href::"/guide/topics/resources/providing-resources.html#UiModeQualifier">no
* UI mode type</a> resource qualifier specified.
*/
UI_MODE_TYPE_NORMAL :: 0x01
/**
* UI mode: value that corresponds to
* <a href::"/guide/topics/resources/providing-resources.html#UiModeQualifier">desk</a> resource qualifier specified.
*/
UI_MODE_TYPE_DESK :: 0x02
/**
* UI mode: value that corresponds to
* <a href::"/guide/topics/resources/providing-resources.html#UiModeQualifier">car</a> resource qualifier specified.
*/
UI_MODE_TYPE_CAR :: 0x03
/**
* UI mode: value that corresponds to
* <a href::"/guide/topics/resources/providing-resources.html#UiModeQualifier">television</a> resource qualifier specified.
*/
UI_MODE_TYPE_TELEVISION :: 0x04
/**
* UI mode: value that corresponds to
* <a href::"/guide/topics/resources/providing-resources.html#UiModeQualifier">appliance</a> resource qualifier specified.
*/
UI_MODE_TYPE_APPLIANCE :: 0x05
/**
* UI mode: value that corresponds to
* <a href::"/guide/topics/resources/providing-resources.html#UiModeQualifier">watch</a> resource qualifier specified.
*/
UI_MODE_TYPE_WATCH :: 0x06
/**
* UI mode: value that corresponds to
* <a href::"/guide/topics/resources/providing-resources.html#UiModeQualifier">vr</a> resource qualifier specified.
*/
UI_MODE_TYPE_VR_HEADSET :: 0x07

/** UI night mode: not specified.*/
UI_MODE_NIGHT_ANY :: 0x00
/**
* UI night mode: value that corresponds to
* <a href::"/guide/topics/resources/providing-resources.html#NightQualifier">notnight</a> resource qualifier specified.
*/
UI_MODE_NIGHT_NO :: 0x1
/**
* UI night mode: value that corresponds to
* <a href::"/guide/topics/resources/providing-resources.html#NightQualifier">night</a> resource qualifier specified.
*/
UI_MODE_NIGHT_YES :: 0x2

/** Screen width DPI: not specified. */
SCREEN_WIDTH_DP_ANY :: 0x0000

/** Screen height DPI: not specified. */
SCREEN_HEIGHT_DP_ANY :: 0x0000

/** Smallest screen width DPI: not specified.*/
SMALLEST_SCREEN_WIDTH_DP_ANY :: 0x0000

/** Layout direction: not specified. */
LAYOUTDIR_ANY  :: 0x00
/**
* Layout direction: value that corresponds to
* <a href::"/guide/topics/resources/providing-resources.html#LayoutDirectionQualifier">ldltr</a> resource qualifier specified.
*/
LAYOUTDIR_LTR  :: 0x01
/**
* Layout direction: value that corresponds to
* <a href::"/guide/topics/resources/providing-resources.html#LayoutDirectionQualifier">ldrtl</a> resource qualifier specified.
*/
LAYOUTDIR_RTL  :: 0x02

/**
* Bit mask for
* <a href::"/guide/topics/resources/providing-resources.html#MccQualifier">mcc</a>
* configuration.
*/
MCC :: 0x0001
/**
* Bit mask for
* <a href::"/guide/topics/resources/providing-resources.html#MccQualifier">mnc</a>
* configuration.
*/
MNC :: 0x0002
/**
* Bit mask for
* <a href::"/guide/topics/resources/providing-resources.html#LocaleQualifier">locale</a>
* configuration.
*/
LOCALE :: 0x0004
/**
* Bit mask for
* <a href::"/guide/topics/resources/providing-resources.html#TouchscreenQualifier">touchscreen</a>
* configuration.
*/
TOUCHSCREEN :: 0x0008
/**
* Bit mask for
* <a href::"/guide/topics/resources/providing-resources.html#ImeQualifier">keyboard</a>
* configuration.
*/
KEYBOARD :: 0x0010
/**
* Bit mask for
* <a href::"/guide/topics/resources/providing-resources.html#KeyboardAvailQualifier">keyboardHidden</a>
* configuration.
*/
KEYBOARD_HIDDEN :: 0x0020
/**
* Bit mask for
* <a href::"/guide/topics/resources/providing-resources.html#NavigationQualifier">navigation</a>
* configuration.
*/
NAVIGATION :: 0x0040
/**
* Bit mask for
* <a href::"/guide/topics/resources/providing-resources.html#OrientationQualifier">orientation</a>
* configuration.
*/
ORIENTATION :: 0x0080
/**
* Bit mask for
* <a href::"/guide/topics/resources/providing-resources.html#DensityQualifier">density</a>
* configuration.
*/
DENSITY :: 0x0100
/**
* Bit mask for
* <a href::"/guide/topics/resources/providing-resources.html#ScreenSizeQualifier">screen size</a>
* configuration.
*/
SCREEN_SIZE :: 0x0200
/**
* Bit mask for
* <a href::"/guide/topics/resources/providing-resources.html#VersionQualifier">platform version</a>
* configuration.
*/
VERSION :: 0x0400
/**
* Bit mask for screen layout configuration.
*/
SCREEN_LAYOUT :: 0x0800
/**
* Bit mask for
* <a href::"/guide/topics/resources/providing-resources.html#UiModeQualifier">ui mode</a>
* configuration.
*/
UI_MODE :: 0x1000
/**
* Bit mask for
* <a href::"/guide/topics/resources/providing-resources.html#SmallestScreenWidthQualifier">smallest screen width</a>
* configuration.
*/
SMALLEST_SCREEN_SIZE :: 0x2000
/**
* Bit mask for
* <a href::"/guide/topics/resources/providing-resources.html#LayoutDirectionQualifier">layout direction</a>
* configuration.
*/
LAYOUTDIR :: 0x4000
SCREEN_ROUND :: 0x8000
/**
* Bit mask for
* <a href::"/guide/topics/resources/providing-resources.html#WideColorGamutQualifier">wide color gamut</a>
* and <a href::"/guide/topics/resources/providing-resources.html#HDRQualifier">HDR</a> configurations.
*/
COLOR_MODE :: 0x10000
/**
* Constant used to to represent MNC (Mobile Network Code) zero.
* 0 cannot be used since it is used to represent an undefined MNC.
*/
MNC_ZERO :: 0xffff


/**
 * {@link AConfiguration} is an opaque type used to get and set
 * various subsystem configurations.
 *
 * A {@link AConfiguration} pointer can be obtained using:
 * - AConfiguration_new()
 * - AConfiguration_fromAssetManager()
 */
AConfiguration :: struct{}

foreign android {
	/**
	 * Create a new AConfiguration, initialized with no values set.
	 */
	AConfiguration_new :: proc() -> ^AConfiguration ---

	/**
	* Free an AConfiguration that was previously created with
	* AConfiguration_new().
	*/
	AConfiguration_delete :: proc(config: ^AConfiguration) ---

	/**
	* Create and return a new AConfiguration based on the current configuration in
	* use in the given {@link AAssetManager}.
	*/
	AConfiguration_fromAssetManager :: proc(out: ^AConfiguration, am: ^AAssetManager) ---

	/**
	* Copy the contents of 'src' to 'dest'.
	*/
	AConfiguration_copy :: proc(dest: ^AConfiguration, src: ^AConfiguration) ---

	/**
	* Return the current MCC set in the configuration.  0 if not set.
	*/
	AConfiguration_getMcc :: proc(config: ^AConfiguration) -> i32 ---

	/**
	* Set the current MCC in the configuration.  0 to clear.
	*/
	AConfiguration_setMcc :: proc(config: ^AConfiguration, mcc: i32) ---

	/**
	* Return the current MNC set in the configuration.  0 if not set.
	*/
	AConfiguration_getMnc :: proc(config: ^AConfiguration) -> i32 ---

	/**
	* Set the current MNC in the configuration.  0 to clear.
	*/
	AConfiguration_setMnc :: proc(config: ^AConfiguration, mnc: i32) ---

	/**
	* Return the current language code set in the configuration.  The output will
	* be filled with an array of two characters.  They are not 0-terminated.  If
	* a language is not set, they will be 0.
	*/
	AConfiguration_getLanguage :: proc(config: ^AConfiguration, outLanguage: [^]byte) ---

	/**
	* Set the current language code in the configuration, from the first two
	* characters in the string.
	*/
	AConfiguration_setLanguage :: proc(config: ^AConfiguration, language: cstring) ---

	/**
	* Return the current country code set in the configuration.  The output will
	* be filled with an array of two characters.  They are not 0-terminated.  If
	* a country is not set, they will be 0.
	*/
	AConfiguration_getCountry :: proc(config: ^AConfiguration, outCountry: [^]byte) ---

	/**
	* Set the current country code in the configuration, from the first two
	* characters in the string.
	*/
	AConfiguration_setCountry :: proc(config: ^AConfiguration, country: cstring) ---

	/**
	* Return the current ACONFIGURATION_ORIENTATION_* set in the configuration.
	*/
	AConfiguration_getOrientation :: proc(config: ^AConfiguration) -> i32 ---

	/**
	* Set the current orientation in the configuration.
	*/
	AConfiguration_setOrientation :: proc(config: ^AConfiguration, orientation: i32) ---

	/**
	* Return the current ACONFIGURATION_TOUCHSCREEN_* set in the configuration.
	*/
	AConfiguration_getTouchscreen :: proc(config: ^AConfiguration) -> i32 ---

	/**
	* Set the current touchscreen in the configuration.
	*/
	AConfiguration_setTouchscreen :: proc(config: ^AConfiguration, touchscreen: i32) ---

	/**
	* Return the current ACONFIGURATION_DENSITY_* set in the configuration.
	*/
	AConfiguration_getDensity :: proc(config: ^AConfiguration) -> i32 ---

	/**
	* Set the current density in the configuration.
	*/
	AConfiguration_setDensity :: proc(config: ^AConfiguration, density: i32) ---

	/**
	* Return the current ACONFIGURATION_KEYBOARD_* set in the configuration.
	*/
	AConfiguration_getKeyboard :: proc(config: ^AConfiguration) -> i32 ---

	/**
	* Set the current keyboard in the configuration.
	*/
	AConfiguration_setKeyboard :: proc(config: ^AConfiguration, keyboard: i32) ---

	/**
	* Return the current ACONFIGURATION_NAVIGATION_* set in the configuration.
	*/
	AConfiguration_getNavigation :: proc(config: ^AConfiguration) -> i32 ---

	/**
	* Set the current navigation in the configuration.
	*/
	AConfiguration_setNavigation :: proc(config: ^AConfiguration, navigation: i32) ---

	/**
	* Return the current ACONFIGURATION_KEYSHIDDEN_* set in the configuration.
	*/
	AConfiguration_getKeysHidden :: proc(config: ^AConfiguration) -> i32 ---

	/**
	* Set the current keys hidden in the configuration.
	*/
	AConfiguration_setKeysHidden :: proc(config: ^AConfiguration, keysHidden: i32) ---

	/**
	* Return the current ACONFIGURATION_NAVHIDDEN_* set in the configuration.
	*/
	AConfiguration_getNavHidden :: proc(config: ^AConfiguration) -> i32 ---

	/**
	* Set the current nav hidden in the configuration.
	*/
	AConfiguration_setNavHidden :: proc(config: ^AConfiguration, navHidden: i32) ---

	/**
	* Return the current SDK (API) version set in the configuration.
	*/
	AConfiguration_getSdkVersion :: proc(config: ^AConfiguration) -> i32 ---

	/**
	* Set the current SDK version in the configuration.
	*/
	AConfiguration_setSdkVersion :: proc(config: ^AConfiguration, sdkVersion: i32) ---

	/**
	* Return the current ACONFIGURATION_SCREENSIZE_* set in the configuration.
	*/
	AConfiguration_getScreenSize :: proc(config: ^AConfiguration) -> i32 ---

	/**
	* Set the current screen size in the configuration.
	*/
	AConfiguration_setScreenSize :: proc(config: ^AConfiguration, screenSize: i32) ---

	/**
	* Return the current ACONFIGURATION_SCREENLONG_* set in the configuration.
	*/
	AConfiguration_getScreenLong :: proc(config: ^AConfiguration) -> i32 ---

	/**
	* Set the current screen long in the configuration.
	*/
	AConfiguration_setScreenLong :: proc(config: ^AConfiguration, screenLong: i32) ---

	/**
	* Return the current ACONFIGURATION_SCREENROUND_* set in the configuration.
	*
	* Available since API level 30.
	*/
	AConfiguration_getScreenRound :: proc(config: ^AConfiguration) -> i32 ---

	/**
	* Set the current screen round in the configuration.
	*/
	AConfiguration_setScreenRound :: proc(config: ^AConfiguration, screenRound: i32) ---

	/**
	* Return the current ACONFIGURATION_UI_MODE_TYPE_* set in the configuration.
	*/
	AConfiguration_getUiModeType :: proc(config: ^AConfiguration) -> i32 ---

	/**
	* Set the current UI mode type in the configuration.
	*/
	AConfiguration_setUiModeType :: proc(config: ^AConfiguration, uiModeType: i32) ---

	/**
	* Return the current ACONFIGURATION_UI_MODE_NIGHT_* set in the configuration.
	*/
	AConfiguration_getUiModeNight :: proc(config: ^AConfiguration) -> i32 ---

	/**
	* Set the current UI mode night in the configuration.
	*/
	AConfiguration_setUiModeNight :: proc(config: ^AConfiguration, uiModeNight: i32) ---

	/**
	* Return the current configuration screen width in dp units, or
	* ACONFIGURATION_SCREEN_WIDTH_DP_ANY if not set.
	*/
	AConfiguration_getScreenWidthDp :: proc(config: ^AConfiguration) -> i32 ---

	/**
	* Set the configuration's current screen width in dp units.
	*/
	AConfiguration_setScreenWidthDp :: proc(config: ^AConfiguration, value: i32) ---

	/**
	* Return the current configuration screen height in dp units, or
	* ACONFIGURATION_SCREEN_HEIGHT_DP_ANY if not set.
	*/
	AConfiguration_getScreenHeightDp :: proc(config: ^AConfiguration) -> i32 ---

	/**
	* Set the configuration's current screen width in dp units.
	*/
	AConfiguration_setScreenHeightDp :: proc(config: ^AConfiguration, value: i32) ---

	/**
	* Return the configuration's smallest screen width in dp units, or
	* ACONFIGURATION_SMALLEST_SCREEN_WIDTH_DP_ANY if not set.
	*/
	AConfiguration_getSmallestScreenWidthDp :: proc(config: ^AConfiguration) -> i32 ---

	/**
	* Set the configuration's smallest screen width in dp units.
	*/
	AConfiguration_setSmallestScreenWidthDp :: proc(config: ^AConfiguration, value: i32) ---

	/**
	* Return the configuration's layout direction, or
	* ACONFIGURATION_LAYOUTDIR_ANY if not set.
	*
	* Available since API level 17.
	*/
	AConfiguration_getLayoutDirection :: proc(config: ^AConfiguration) -> i32 ---

	/**
	* Set the configuration's layout direction.
	*
	* Available since API level 17.
	*/
	AConfiguration_setLayoutDirection :: proc(config: ^AConfiguration, value: i32) ---

	/**
	* Perform a diff between two configurations.  Returns a bit mask of
	* ACONFIGURATION_* constants, each bit set meaning that configuration element
	* is different between them.
	*/
	AConfiguration_diff :: proc(config1: ^AConfiguration, config2: ^AConfiguration) -> i32 ---

	/**
	* Determine whether 'base' is a valid configuration for use within the
	* environment 'requested'.  Returns 0 if there are any values in 'base'
	* that conflict with 'requested'.  Returns 1 if it does not conflict.
	*/
	AConfiguration_match :: proc(base: ^AConfiguration, requested: ^AConfiguration) -> i32 ---

	/**
	* Determine whether the configuration in 'test' is better than the existing
	* configuration in 'base'.  If 'requested' is non-NULL, this decision is based
	* on the overall configuration given there.  If it is NULL, this decision is
	* simply based on which configuration is more specific.  Returns non-0 if
	* 'test' is better than 'base'.
	*
	* This assumes you have already filtered the configurations with
	* AConfiguration_match().
	*/
	AConfiguration_isBetterThan :: proc(base: ^AConfiguration, test: ^AConfiguration, requested: ^AConfiguration) -> i32 ---
}
