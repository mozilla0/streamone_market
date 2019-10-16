#Requires -Version 3.0
gci env:* | sort-object name;

$srvsql = $env:APPSETTING_key1;
$usrsql = $env:APPSETTING_key2;
$psdsql = $env:APPSETTING_key3;

$webConfig = 'D:\HOME\site\wwwroot\Web.config'
$doc = (Get-Content $webConfig) -as [Xml]

$obj = $doc.configuration.appSettings.add | where {$_.Key -eq 'MicrosoftClientId'}
$obj.value = $env:APPSETTING_key5;

$objpas = $doc.configuration.appSettings.add | where {$_.Key -eq 'MicrosoftClientSecret'}
$objpas.value = $env:APPSETTING_key6;

$allowres = $doc.configuration.appSettings.add | where {$_.Key -eq 'AllowedResellers'}
$allowres.value = $env:APPSETTING_key7;

$clientid = $doc.configuration.appSettings.add | where {$_.Key -eq 'ClientId'}
$clientid.value = $env:APPSETTING_key5;

$notificationEmails = $doc.configuration.appSettings.add | where {$_.Key -eq 'NotificationEmails'}
$notificationEmails.value = $env:APPSETTING_key13;

$notificationEmailFrom = $doc.configuration.appSettings.add | where {$_.Key -eq 'NotificationEmailFrom'}
$notificationEmailFrom.value = $env:APPSETTING_key14;

$root = $doc.get_DocumentElement();
$pllConString = $root.connectionStrings.add | ? {$_.name -eq 'PLLConnection'}
$pllnewCon = $pllConString.connectionString.Replace('Server=;Initial Catalog=;Persist Security Info=False;User ID=;Password=;','Server='+$srvsql+';Initial Catalog=cpssodb;Persist Security Info=False;User ID='+$usrsql+';Password='+$psdsql+';');
$pllConString.connectionString = $pllnewCon


$PrivateLabelConString = $root.connectionStrings.add | ? {$_.name -eq 'PrivateLabelLiteDataEntities'}
$newPrivateLabelConString = $PrivateLabelConString.connectionString.Replace('data source=;initial catalog=plltest;User ID=;Password=','data source='+$srvsql+';Initial Catalog=cpssodb;User ID='+$usrsql+';Password='+$psdsql);
$PrivateLabelConString.connectionString = $newPrivateLabelConString

$root."system.net".mailSettings.smtp.network.userName = $env:APPSETTING_key14
$root."system.net".mailSettings.smtp.network.password = $env:APPSETTING_key15
 
$doc.Save($webConfig)

  