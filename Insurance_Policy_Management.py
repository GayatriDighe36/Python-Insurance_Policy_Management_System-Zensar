import json
from http.server import BaseHTTPRequestHandler, HTTPServer
import mysql.connector
from urllib.parse import urlparse, parse_qs

# Database configuration
DB_CONFIG = {
    'user': 'root',
    'password': 'password',
    'host': 'localhost',
    'database': 'InsuranceDB'
}

class RequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        parsed_path = urlparse(self.path)
        query_params = parse_qs(parsed_path.query)
        path = parsed_path.path

        try:
            connection = mysql.connector.connect(**DB_CONFIG)
            cursor = connection.cursor(dictionary=True)

            if path == "/customers":
                cursor.execute("SELECT * FROM Customers")
                data = cursor.fetchall()
                self._send_response(200, data)

            elif path == "/policies":
                cursor.execute("SELECT * FROM Policies")
                data = cursor.fetchall()
                self._send_response(200, data)

            else:
                self._send_response(404, {"error": "Endpoint not found"})

        except Exception as e:
            self._send_response(500, {"error": str(e)})

        finally:
            cursor.close()
            connection.close()

    def do_POST(self):
        parsed_path = urlparse(self.path)
        path = parsed_path.path

        content_length = int(self.headers['Content-Length'])
        post_data = json.loads(self.rfile.read(content_length))

        try:
            connection = mysql.connector.connect(**DB_CONFIG)
            cursor = connection.cursor()

            if path == "/customers":
                cursor.execute("""
                    INSERT INTO Customers (name, email, phone) 
                    VALUES (%s, %s, %s)
                """, (post_data['name'], post_data['email'], post_data['phone']))
                connection.commit()
                self._send_response(201, {"message": "Customer added successfully"})

            else:
                self._send_response(404, {"error": "Endpoint not found"})

        except Exception as e:
            self._send_response(500, {"error": str(e)})

        finally:
            cursor.close()
            connection.close()

    def _send_response(self, status, data):
        self.send_response(status)
        self.send_header('Content-Type', 'application/json')
        self.end_headers()
        self.wfile.write(json.dumps(data).encode('utf-8'))


def run(server_class=HTTPServer, handler_class=RequestHandler, port=8080):
    server_address = ('', port)
    httpd
