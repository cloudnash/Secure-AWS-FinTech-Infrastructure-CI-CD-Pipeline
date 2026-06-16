from flask import Flask, jsonify
import os

app = Flask(__name__)

@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({"status": "healthy", "message": "Service is running"}), 200

@app.route('/api/v1/payroll/status', methods=['GET'])
def payroll_status():
    # Simulating RBAC and Secrets Manager retrieval in a real app
    return jsonify({
        "message": "Secure Access Granted: Company Environment",
        "environment": os.getenv("ENV", "production"),
        "compliance": "GDPR-encrypted data simulated",
        "payroll_processed": True
    }), 200

if __name__ == '__main__':
    # Running securely on a non-privileged port
    app.run(host='0.0.0.0', port=8080)
