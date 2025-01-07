

### What Happens When We Type `www.google.com` in a Browser?

1. **Browser Check**:
   - The browser first checks its **DNS cache** for the IP address of `www.google.com`.
   - If found, it uses the cached IP to connect to the server.

2. **DNS Resolution**:
   - If the IP is not cached, the browser sends a query to the **recursive DNS resolver** (ISP or third-party like Google DNS).
   - The resolver queries DNS servers in a hierarchy:
     1. **Root DNS Server**: Points to the `.com` TLD name server.
     2. **TLD Name Server**: Points to the authoritative name server for `google.com`.
     3. **Authoritative Name Server**: Returns the IP address for `www.google.com`.
   - The resolver caches the IP address and sends it to the browser.

3. **TCP Handshake**:
   - The browser initiates a **TCP connection** to the server using the resolved IP address (default port 80 for HTTP or 443 for HTTPS).
   - This involves a **three-way handshake**:
     - **SYN**: Browser sends a connection request.
     - **SYN-ACK**: Server acknowledges.
     - **ACK**: Browser confirms.

4. **TLS Handshake (for HTTPS)**:
   - If using HTTPS, a **TLS handshake** occurs to establish a secure connection.
   - Browser and server exchange certificates, agree on encryption algorithms, and generate session keys.

5. **HTTP Request**:
   - The browser sends an **HTTP GET request** for the webpage to the server.

6. **Server Response**:
   - The server processes the request and sends back an **HTTP response** with the webpage content (HTML, CSS, JavaScript, etc.).

7. **Rendering**:
   - The browser parses the received HTML and makes additional requests for resources like images, CSS, and JavaScript files.
   - It builds the **DOM tree**, **CSSOM tree**, and combines them into the **render tree**.
   - The browser paints the content on the screen.

### Key Points:
- **Caching**: DNS records, TCP connections, and resources (like images) are cached to improve performance.
- **CDN**: Content Delivery Networks may be involved, directing requests to the nearest server for faster delivery.
- **Load Balancer**: Requests to `www.google.com` may be distributed across multiple servers using load balancers. 

This flow involves DNS resolution, establishing connections, and rendering, ensuring seamless delivery of the webpage to the user.
