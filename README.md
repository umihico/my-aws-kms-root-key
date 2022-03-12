# my-aws-shared-kms-key

Terraform module which creates kms key with the cheapest configuration.

## Deploy

```bash
terragrunt apply
```

## Encryption

```bash
aws kms encrypt \
  --key-id alias/shared-key \
  --plaintext "$(echo -n 'AKIAIOSFODNN7EXAMPLE' | base64)" \
  --output text \
  --query CiphertextBlob

# returns AQICAHhknPcMN2mPQjlgkKH9EhrUk79o+4j1nUtJMmNPXkAKWgGrFXbz4w9iSuiCzjg7ZHnlAAAAcjBwBgkqhkiG9w0BBwagYzBhAgEAMFwGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMIVCeo7QO+WVVAtseAgEQgC/0OvgZWsK8sicF3Uwdlh1K2yCCzmn3FPWh/++W4rQ9iPcc8QoEji8zyOBwnMtdKw==
```

## Decription

```bash
aws kms decrypt \
  --ciphertext-blob fileb://<(echo "AQICAHhknPcMN2mPQjlgkKH9EhrUk79o+4j1nUtJMmNPXkAKWgGrFXbz4w9iSuiCzjg7ZHnlAAAAcjBwBgkqhkiG9w0BBwagYzBhAgEAMFwGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMIVCeo7QO+WVVAtseAgEQgC/0OvgZWsK8sicF3Uwdlh1K2yCCzmn3FPWh/++W4rQ9iPcc8QoEji8zyOBwnMtdKw==" | base64 -d) \
  --output text \
  --query Plaintext \
  | base64 -d

# returns AKIAIOSFODNN7EXAMPLE
```