//+build android
package android

foreign import android "system:android"

/**
 * The corresponding C type for android.net.Network#getNetworkHandle() return
 * values.  The Java signed long value can be safely cast to a net_handle_t:
 *
 *     [C]    ((net_handle_t) java_long_network_handle)
 *     [C++]  static_cast<net_handle_t>(java_long_network_handle)
 *
 * as appropriate.
 */
net_handle_t :: distinct u64 

uid_t :: u32

/**
 * The value NETWORK_UNSPECIFIED indicates no specific network.
 *
 * For some functions (documented below), a previous binding may be cleared
 * by an invocation with NETWORK_UNSPECIFIED.
 *
 * Depending on the context it may indicate an error.  It is expressly
 * not used to indicate some notion of the "current default network".
 */
NETWORK_UNSPECIFIED :: net_handle_t(0)

/**
* Possible values of the flags argument to android_res_nsend and android_res_nquery.
* Values are ORed together.
*/
ResNsendFlagsBits :: enum u32 {
	/**
	* Send a single request to a single resolver and fail on timeout or network errors
	*/
	RESOLV_NO_RETRY = 0,

	/**
	* Don't lookup this request in the cache, and don't cache the result of the lookup.
	* This flag implies {@link #ANDROID_RESOLV_NO_CACHE_LOOKUP}.
	*/
	RESOLV_NO_CACHE_STORE = 1,

	/**
	* Don't lookup the request in cache.
	*/
	RESOLV_NO_CACHE_LOOKUP = 2,
}

ResNsendFlags :: bit_set[ResNsendFlagsBits; u32]

foreign android {
	/**
	 * All functions below that return an i32 return 0 on success or -1
	 * on failure with an appropriate errno value set.
	 */

	/**
	 * Set the network to be used by the given socket file descriptor.
	 *
	 * To clear a previous socket binding, invoke with NETWORK_UNSPECIFIED.
	 *
	 * This is the equivalent of: [android.net.Network#bindSocket()](https://developer.android.com/reference/android/net/Network.html#bindSocket(java.net.Socket))
	 *
	 * Available since API level 23.
	 */
	android_setsocknetwork :: proc(network: net_handle_t, fd: i32) -> i32 ---


	/**
	* Binds the current process to |network|.  All sockets created in the future
	* (and not explicitly bound via android_setsocknetwork()) will be bound to
	* |network|.  All host name resolutions will be limited to |network| as well.
	* Note that if the network identified by |network| ever disconnects, all
	* sockets created in this way will cease to work and all host name
	* resolutions will fail.  This is by design so an application doesn't
	* accidentally use sockets it thinks are still bound to a particular network.
	*
	* To clear a previous process binding, invoke with NETWORK_UNSPECIFIED.
	*
	* This is the equivalent of: [android.net.ConnectivityManager#bindProcessToNetwork()](https://developer.android.com/reference/android/net/ConnectivityManager.html#bindProcessToNetwork(android.net.Network))
	*
	* Available since API level 23.
	*/
	android_setprocnetwork :: proc(network: net_handle_t) -> i32 ---


	/**
	* Gets the |network| bound to the current process, as per android_setprocnetwork.
	*
	* This is the equivalent of: [android.net.ConnectivityManager#getBoundNetworkForProcess()](https://developer.android.com/reference/android/net/ConnectivityManager.html#getBoundNetworkForProcess(android.net.Network))
	* Returns 0 on success, or -1 setting errno to EINVAL if a null pointer is
	* passed in.
	*
	*
	* Available since API level 31.
	*/
	android_getprocnetwork :: proc(network: ^net_handle_t) -> i32 ---

	/**
	* Binds domain name resolutions performed by this process to |network|.
	* android_setprocnetwork takes precedence over this setting.
	*
	* To clear a previous process binding, invoke with NETWORK_UNSPECIFIED.
	* On success 0 is returned. On error -1 is returned, and errno is set.
	*
	* Available since API level 31.
	*/
	android_setprocdns :: proc(network: net_handle_t) -> i32 ---

	/**
	* Gets the |network| to which domain name resolutions are bound on the
	* current process.
	*
	* Returns 0 on success, or -1 setting errno to EINVAL if a null pointer is
	* passed in.
	*
	* Available since API level 31.
	*/
	android_getprocdns :: proc(network: ^net_handle_t) -> i32 ---


	/**
	* Perform hostname resolution via the DNS servers associated with |network|.
	*
	* All arguments (apart from |network|) are used identically as those passed
	* to getaddrinfo(3).  Return and error values are identical to those of
	* getaddrinfo(3), and in particular gai_strerror(3) can be used as expected.
	* Similar to getaddrinfo(3):
	*     - |hints| may be NULL (in which case man page documented defaults apply)
	*     - either |node| or |service| may be NULL, but not both
	*     - |res| must not be NULL
	*
	* This is the equivalent of: [android.net.Network#getAllByName()](https://developer.android.com/reference/android/net/Network.html#getAllByName(java.lang.String))
	*
	* Available since API level 23.
	*/
	android_getaddrinfofornetwork :: proc(network: net_handle_t, node: cstring, service: cstring, hints: ^addrinfo, res: ^^addrinfo) -> i32 ---

	/**
	* Look up the {|ns_class|, |ns_type|} Resource Record (RR) associated
	* with Domain Name |dname| on the given |network|.
	* The typical value for |ns_class| is ns_c_in, while |type| can be any
	* record type (for instance, ns_t_aaaa or ns_t_txt).
	* |flags| is a additional config to control actual querying behavior, see
	* ResNsendFlags for detail.
	*
	* Returns a file descriptor to watch for read events, or a negative
	* POSIX error code (see errno.h) if an immediate error occurs.
	*
	* Available since API level 29.
	*/
	android_res_nquery :: proc(network: net_handle_t, dname: cstring, ns_class: i32, ns_type: i32, flags: ResNsendFlags) -> i32 ---

	/**
	* Issue the query |msg| on the given |network|.
	* |flags| is a additional config to control actual querying behavior, see
	* ResNsendFlags for detail.
	*
	* Returns a file descriptor to watch for read events, or a negative
	* POSIX error code (see errno.h) if an immediate error occurs.
	*
	* Available since API level 29.
	*/
	android_res_nsend :: proc(network: net_handle_t, msg: [^]byte, msglen: uint, flags: ResNsendFlags) -> i32 ---

	/**
	* Read a result for the query associated with the |fd| descriptor.
	* Closes |fd| before returning.
	*
	* Available since 29.
	*
	* Returns:
	*     < 0: negative POSIX error code (see errno.h for possible values). |rcode| is not set.
	*     >= 0: length of |answer|. |rcode| is the resolver return code (e.g., ns_r_nxdomain)
	*/
	android_res_nresult :: proc(fd: i32, rcode: ^int, answer: [^]byte, anslen: uint) -> i32 ---

	/**
	* Attempts to cancel the in-progress query associated with the |nsend_fd|
	* descriptor.
	*
	* Available since API level 29.
	*/
	android_res_cancel :: proc(nsend_fd: i32) ---

	/*
	* Set the socket tag and owning UID for traffic statistics on the specified
	* socket.
	*
	* Subsequent calls always replace any existing parameters. The socket tag and
	* uid (if set) are kept when the socket is sent to another process using binder
	* IPCs or other mechanisms such as UNIX socket fd passing. Any app can accept
	* blame for future traffic performed on a socket originally created by another
	* app by calling this method with its own UID (or calling
	* android_tag_socket(int sockfd, int tag)). However, only apps holding the
	* android.Manifest.permission#UPDATE_DEVICE_STATS permission may assign blame
	* to another UIDs. If unset (default) the socket tag is 0, and the uid is the
	* socket creator's uid.
	*
	* Returns 0 on success, or a negative POSIX error code (see errno.h) on
	* failure.
	*
	* Available since API level 33.
	*/
	android_tag_socket_with_uid :: proc(sockfd: i32, tag: u32, uid: uid_t) -> i32 ---

	/*
	* Set the socket tag for traffic statistics on the specified socket.
	*
	* This function tags the socket with the caller's UID (accepting blame for
	* future traffic performed on this socket) even if the socket was originally
	* opened by another UID or was previously tagged by another UID. Subsequent
	* calls always replace any existing parameters. The socket tag is kept when the
	* socket is sent to another process using binder IPCs or other mechanisms such
	* as UNIX socket fd passing. The tag is a value defined by the caller and used
	* together with uid for data traffic accounting, so that the function callers
	* can account different types of data usage for a uid.
	*
	* Returns 0 on success, or a negative POSIX error code (see errno.h) on
	* failure.
	*
	* Some possible error codes:
	* -EBADF           Bad socketfd.
	* -EPERM           No permission.
	* -EAFNOSUPPORT    Socket family is neither AF_INET nor AF_INET6.
	* -EPROTONOSUPPORT Socket protocol is neither IPPROTO_UDP nor IPPROTO_TCP.
	* -EMFILE          Too many stats entries.
	* There are still other error codes that may provided by -errno of
	* [getsockopt()](https://man7.org/linux/man-pages/man2/getsockopt.2.html) or by
	* BPF maps read/write sys calls, which are set appropriately.
	*
	* Available since API level 33.
	*/
	android_tag_socket :: proc(sockfd: i32, tag: u32) -> i32 ---

	/*
	* Untag a network socket.
	*
	* Future traffic on this socket will no longer be associated with any
	* previously configured tag and uid. If the socket was created by another UID
	* or was previously tagged by another UID, calling this function will clear the
	* statistics parameters, and thus the UID blamed for traffic on the socket will
	* be the UID that originally created the socket, even if the socket was
	* subsequently tagged by a different UID.
	*
	* Returns 0 on success, or a negative POSIX error code (see errno.h) on
	* failure.
	*
	* One of possible error code:
	* -EBADF           Bad socketfd.
	* Other error codes are either provided by -errno of
	* [getsockopt()](https://man7.org/linux/man-pages/man2/getsockopt.2.html) or by
	* BPF map element deletion sys call, which are set appropriately.
	*
	* Available since API level 33.
	*/
	android_untag_socket :: proc(sockfd: i32) -> i32 ---
}

