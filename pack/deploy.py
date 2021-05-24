# Select the template to use for creating the domain

selectTemplate('Basic WebLogic Server Domain','14.1.1.0.0')
loadTemplates()

# Set the listen address and listen port for the Administration Server

cd('/Servers/AdminServer')
set('ListenAddress','')
set('ListenPort',7003)

#Enable SSL on the Administration Server and set the SSL listen address and Port

create('AdminServer','SSL')
cd('SSL/AdminServer')
set('Enabled','false')
set('ListenPort', 7002)

# Set the domain password for the WebLogic Server administration user

cd('/')
cd('Security/base_domain/User/weblogic')
cmo.setPassword('weblogic@123')

# If the domain already exists, overwrite the domain

setOption('OverwriteDomain','true')

# write the domain and close the template

writeDomain('/data/Oracle/Middleware/Oracle_Home/user_projects/domains/sit_domain')
closeTemplate()
exit()

