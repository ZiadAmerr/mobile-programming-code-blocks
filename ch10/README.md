# Notes from Lecture Notes
**Notes from Lecture Slides are at the bottom of this page**

## Common App Security Threats
* **Malware**: Virus, Trojan, Worm, Ransomware $\rightarrow$ Data breaches & unauthorized access
* **Phishing**: Imitate legit services $\rightarrow$ Steal sensitive information
* **MitM**: Intercept communication $\rightarrow$ Steal sensitive information
* **Insecure Data Storage**: Store sensitive data in plain text $\rightarrow$ Data breaches
* **App Spoofing**: Fake app $\rightarrow$ Steal sensitive information
* **Device Theft**: Steal device $\rightarrow$ Unauthorized access
* **Social Engineering**: Manipulate user $\rightarrow$ Steal sensitive information

## Vulnerabilities
* **Insecure Communication**: HTTP, FTP, Telnet $\rightarrow$ MitM $\rightarrow$ Use HTTPS, SFTP, SSH, and other encrypted protocols
* **Insecure Storage**: Store in containers, encrypt data, use secure APIs
* **Improper Session Handling**: Session tokens intercepted/hijacked $\rightarrow$ Use secure session management
* **Excessive Permissions**: App requests more permissions than needed $\rightarrow$ Use least privilege principle
* **Code Injection**: Inject malicious code (SQLI, XSS) $\rightarrow$ Sanitize input, use prepared statements, use secure APIs
* **Reverse Engineering**: Decompiling, disassembling, debugging $\rightarrow$ Use obfuscation, encryption, secure APIs

## Case Study: Zero-click Attacks
* Exploit VoIP/SIP
    * Calls a user, no need to answer, device is compromised

### Security Measures
* **Secure Communication**: Use HTTPS, SSL/TLS, E2E encryption
* **MFAs**: Use 2FA, MFA, biometrics, Strong Password Policies
* **App Sandboxing**: Isolate app from other apps, OS
* **Update Regularly**: Patch vulnerabilities, update libraries
* **Input Validation**: Protect against SQLI, XSS, CSRF, 
* **Secure APIs**: Avoid exposing sensitive data through APIs
* **Obfuscation**: Sign & obfuscate code, encrypt data


## Security Tools
* **SAST**: Static Application Security Testing
    * **Checkmarx**: Static code analysis
    * **SonarQube**: Code quality & security
* **DAST**: Dynamic Application Security Testing
    * **OWASP ZAP**, **Burp Suite**: Runtime analysis, API misconfig, data leaks
* **MobSF**: Mobile Security Framework
* **Pentesting Tools**: Metasploit Framework, Kali Linux $\rightarrow$ Simulate attacks

## Examples
* **Password Management**: 1Password, LastPass $\rightarrow$ Securely store passwords
* **OTP**: Microsoft Authenticator, Duo Mobile $\rightarrow$ Generate OTPs
* **Anti-Malware**: Malwarebytes, Avast Mobile Security $\rightarrow$ Detect & remove malware


## Standards

### NIST SP 800-53
Comprehensive set of security controls for federal information systems and organizations
- Access Control
- Encryption
- Incident Response

### ISO 27001:2022
Fwk for establishing, implementing, maintaining, app security practices


# Notes from Lecture Slides

* Encryption in:
    * Transit: Use HTTPS, SSL/TLS
    * Rest: Use AES

* Secure employee devices using Mobile Device Management (MDM)
    * Remote wipe, lock, locate, etc.

* Future of Security
    * Use ML, AI for threat detection
    * Bio-metrics, facial recognition
    * Zero Trust Architecture
    