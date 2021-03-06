A simplistic Windows app sandbox. Needs setup - read below.

Adds a right-click action to run the specified program as a "sandbox" user, and tries to force the app to not ask for UAC elevation.

Useful if you want to run a moderately obnoxious app without the risk of borking your system / account / data. Don't use to run malware! (read below)

Aims:

* Limit what a program can do on the system.

Non-aims:

* Allow programs to do seemingly anything on the system, isolated in a copy-on-write sandbox. / Allow programs to think they have admin permissions. (There are sandboxing tools that can do that, e.g. open-source firejail on linux or commercial sandboxie on windows.)
* Leave no traces after running the program. (There will be many traces, like prefetch files, user-specific registry, etc.)
* Prevent the executed program from hooking other windows, from sniffing keystrokes, from exploiting vulnerabilities in the operating system, drivers, or in other programs that e.g. listen on loopback.

Installation:

* To install, review and run setup_sandbox_user.txt and sandbox_launcher.reg.
* To uninstall, just delete the two registry keys listed below and review and run remove_sandbox_user.txt.

Example usecase:

* I need to edit a single interactive PDF to file taxes, but I really don't want the PDF app for anything else, knowing that it is much less secure than the heavily sandboxed MS Edge PDF viewer, and knowing that less secure third-party Explorer thumbnail integration opens me to new attack vectors https://security.stackexchange.com/q/94356, I don't want to risk it modifying my registry or files, nor installing e.g. thumbnail support or other stuff, so I use this sandbox. I copy the right PortableApp to C:\tmp\RememberToRightClickRunInSandbox, right click it, select "Run in sandbox without privilege elevation", unpack it to C:\tmp\RememberToRightClickRunInSandbox\, and then when I want to run it again, I don't forget to right click the unpacked .exe and select "Run in sandbox without privilege elevation". Because the app might sniff my keystrokes, I log out to kill the processes running in the session or run taskkill /fi "USERNAME eq sandbox" /f.

Details:

* This takes a very minimalistic approach, uses only the native Windows NT security mechanisms and uses only native built-in documented Windows features; doesn't require any permanently running code, drivers.
* Inspired by https://superuser.com/questions/171917/force-a-program-to-run-without-administrator-privileges-or-uac
* Requires a non-admin "sandbox" account to exist. The "sandbox" user MUST have a password set, and the password will be SAVED in your account's Windows Credentials Store after first use, accessible by other processes running in your account, so choose a new random password that has no relations to any other passwords you use.
* Suppression of UAC elevation works only on some apps - just if the app asks for admin in the manifest, not if it forces it through program code.
* Additional \__COMPAT_LAYER fixes are applied to minimize app breakage because of insufficient permissions.
* List of possible \__COMPAT_LAYER options - https://docs.microsoft.com/en-us/windows/deployment/planning/compatibility-fixes-for-windows-8-windows-7-and-windows-vista
* \__COMPAT_LAYER doesn't subvert kernel security - "the same security restrictions apply to the compatibility fix as apply to the application code, which means that you cannot use compatibility fixes to bypass any of the security mechanisms of the operating system" - https://docs.microsoft.com/en-us/windows/deployment/planning/understanding-and-using-compatibility-fixes and https://blogs.technet.microsoft.com/askperf/2011/06/17/demystifying-shims-or-using-the-app-compat-toolkit-to-make-your-old-stuff-work-with-your-new-stuff/
* But it can subvert user space security, so it's important to run it as a limited user, so that the kernel limits what it can do to the "sandbox" user. "Note that the compatibility shim infrastructure performs only in-process shimming. It can alter the way the process internally behaves (or how in-process components like the DLL loader behave), but it doesn't alter the security boundaries between the program and the rest of the system." - https://blogs.msdn.microsoft.com/oldnewthing/20170911-00/?p=96995
* Beware that this approach is not very secure against overly malicious programs that exploit the kernel or inject code into other windows or sniff keystrokes, but is secure against normal programs that just want to change your windows settings, be obnoxious, maybe read your documents, and pollute your system with junk files and registry, such as some ad-sponsored file editors, etc. - see https://hackmag.com/security/win-isolation/
* Supports apps that have spaces in their names through correct application of cmd.exe quoting rules (see cmd /? - in the below case, cmd strips the first and last " and preserves the rest to run, resulting in "%1" being properly enclosed and not broken). Windows doesn't support " in filenames, so as long as you don't run an exe with " in the path, it is secure against cmd injection.

* Works well for e.g. portableapps, if you run them in previously-created directory c:\tmp (or any other directory accessible by guests); the extracted *Portable.exe launcher might not work, but the App/[name]/[name].exe program should work fine.

```
[HKEY_CLASSES_ROOT\*\shell\forcerunasinvokerinsandbox]
@="Run in sandbox without privilege elevation"

[HKEY_CLASSES_ROOT\*\shell\forcerunasinvokerinsandbox\command]
@="runas /noprofile /user:sandbox /savecred \"cmd /C set __COMPAT_LAYER=RUNASINVOKER ForceAdminAccess WrpMitigation VirtualizeDeleteFileLayer VirtualRegistry VirtualizeDeleteFile ProtectedAdminCheck RedirectCRTTempFile RedirectHKCUKeys  && start \\\"\\\" \\\"%1\\\"\""
```
