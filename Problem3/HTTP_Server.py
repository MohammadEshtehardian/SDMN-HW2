from http.server import BaseHTTPRequestHandler, HTTPServer
import json
import cgi

hostName = "localhost"
port = 8000

class MyServer(BaseHTTPRequestHandler):

    ok = True # for checking status
    message = "OK" # message for answer get request

    def do_GET(self):

        if self.path == '/api/v1/status':
            if MyServer.ok:
                self.send_response(200)
            else:
                self.send_response(201)
            self.send_header("Content-type", "application/json")
            self.end_headers()
            self.wfile.write(bytes(json.dumps({"status": MyServer.message}), 'utf-8'))
        
    def do_POST(self):

        if self.path == '/api/v1/status':

            ctype, pdict = cgi.parse_header(self.headers["content-type"])
            pdict["boundary"] = bytes(pdict["boundary"], "utf-8")
            data = cgi.parse_multipart(self.rfile, pdict)

            if data == {"status": "not OK"} and MyServer.ok:
                message = data["status"][0]
                self.send_response(201)
                self.send_header("Content-type", "application/json")
                self.end_headers()
                self.wfile.write(bytes(json.dumps({"status": message}), 'utf-8'))
                MyServer.ok = False
                MyServer.message = message

            elif "status" in data.keys():
                message = data["status"][0]
                self.send_response(201)
                self.send_header("Content-type", "application/json")
                self.end_headers()
                self.wfile.write(bytes(json.dumps({"status": message}), 'utf-8'))
                MyServer.message = message
            


if __name__ == "__main__":        
    webServer = HTTPServer((hostName, port), MyServer)
    print("Server started http://%s:%s" % (hostName, port))

    try:
        webServer.serve_forever()
    except KeyboardInterrupt:
        pass

    webServer.server_close()
    print("Server stopped.")