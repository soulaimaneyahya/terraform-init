# terraform-init

<img src="./imgs/x.webp" alt="terraform-init" />

### Init
```bash
terraform init
```

### Apply Configuration
```bash
terraform plan
terraform plan --out=planfile
```

```bash
terraform apply
```

### Targeting module

```sh
terraform plan -target=linode_instance.linode_servers
terraform apply -target=linode_instance.linode_servers
<service_name><instance_name>
```

### Destory

```bash
terraform destroy
```

Learn more: [Manage AWS infra using terraform](https://engineering.multividas.com/posts/manage-aws-infra-using-terraform)
