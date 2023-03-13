# Terraform code

dev,test,prod - папки для описания инфраструтуры  
shared - общие для окружений ресурсы  
lib - unit-модули   

Для работы необходимо:  
в [shared/settings/outputs.tf](shared/settings/outputs.tf#L36) поменять домен  
Пропипать в окружение YC_TOKEN и YC_CLOUD_ID и aws creds для Yandex Cloud  
Для инициализации тераформа - запустить ./init.sh в рабочей парке и далее terraform apply  
