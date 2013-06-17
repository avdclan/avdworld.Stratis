#define __DEBUG__ true

#ifdef __DEBUG__
	#ifndef SELF
		#define _SELF __FILE__
	#else
		#define _SELF SELF
	#endif
	
	#ifndef __quiet
		#define DLOG(lmessage) diag_log format["%5|%4 %1:%2 %3", _SELF, __LINE__, str(lmessage), diag_frameno, time]; player globalChat str(lmessage)
	#else
		#define DLOG(lmessage) true
	#endif
#endif