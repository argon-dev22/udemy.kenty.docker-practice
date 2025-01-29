# 理解して使う！Docker入門＋応用：初心者から実務で使えるスキルが身に付ける

## Quick Start

### 1. AWSのリソースを作成する

```
cd terraform
terraform init
terraform apply
```

### 2. デプロイする

GitHub Actionsのワークフローを実行。

### 3. デプロイされたサービスを確認する

デプロイされたサービスを確認。

## シークレットの設定

下記のシークレットをGitHub Actionsのリポジトリのシークレットに設定する。

| シークレット名 | 説明 |
|--------------|------|
| AWS_ACCESS_KEY_ID | AWSアクセスキーID |
| AWS_SECRET_ACCESS_KEY | AWSシークレットアクセスキー |
| AWS_ECR_WEB_SERVER_REPOSITORY | ECRリポジトリ名 (Web) |
| AWS_ECR_API_SERVER_REPOSITORY | ECRリポジトリ名 (API) |

