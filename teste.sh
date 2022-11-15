#!/bin/bash
sudo apt install && sudo apt update –y

# instalando interface grafica
echo "Deseja instalar a interface gráfica? (s/n)"
read inst

if [ \"$inst\" == \"s\" ];
then
		sudo apt-get install xrdp lxde-core lxde tigervnc-standalone-server -y
else
		echo "Atualizando Pacotes"
fi

# atualizando pacotes
sudo apt update && sudo apt upgrade -y
java --version

# ver se tem o java instalado
if [ $? -eq 0 ];
then
	echo "Java já está instalado"
else
	echo "Gostaria de instalar o Java? (s/n)"
	read inst
	if [ \"$inst\" == \"s\" ];
	then
		sudo apt install default-jre -y
	fi
fi

# ver se tem o docker instalado
docker --version
if [ $? -eq 0 ];
then
	echo "Docker já está instalado"
else
	# echo "Gostaria de instalar o Docker? e o banco TechHealth? (s/n)"
	# read inst
	# if [ \"$inst\" == \"s\" ];
	then
		sudo apt install docker.io -y
fi

	
echo "Iniciando Docker"
echo "Caminho: "
pwd
sudo systemctl start docker
sudo systemctl enable docker
sudo docker pull mysql:5.7

sudo docker run -d -p 3306:3306 --name containerGrupo9 -e "MYSQL_DATABASE=grupo9"-e"MYSQL_ROOT_PASSWORD=urubu100" mysql:5.7
# cd ~/docker-mysql
# sudo docker-compose up -d
# sudo docker start CONTAINER_TOTEMDB

#comandos mysql
sudo docker exec -it $(sudo docker ps -aqf "name=containerGrupo9") mysql -u root -p -B -N -e "

create database grupo9;
use grupo9;
CREATE TABLE hospital (
idHospital int primary key auto_increment,
nome_Hospital varchar (45),
cnpj varchar(45),
endereco varchar (100),
numeroHospital int,
qtdMaquinas Int
);
create table usuario (
id int primary key auto_increment,
nome varchar (45),
cnpj varchar (45),
email varchar (45),
check (email like '%@%' and email like '%.com%'),
senha varchar (45)
);


insert into hospital values
(null, 'Santa Catarina', '59.546.515/0001-34', 'Av. Paulista', 200, 10);

insert into hospital values
(null, 'Grajau', '18.601.672/0007-91', 'Av. Belmira Marin', 982, 7);

CREATE TABLE maquina (
idMaquina int primary key auto_increment, -- IDENTITY(1,1),
ala_Hospitalar varchar (45), -- inserir manualmente
sistema_Operacional varchar (100), -- sistema.getSistema
fabricante varchar (45), -- sistema.getfabricante
nome_Processador varchar (100), -- processador get.nome
frequencia_Processador decimal (5,2), -- frequencia do processador processador.getfrequencia
capacidade_Total_Memoria decimal(5,2), -- memoria.gettotal
tamanho_Disco decimal(5,2), -- long disco.gettamanho
numero_CPU_fisica int, -- processador.getnumeroscpusfisicas
fkHospital int,
foreign key (fkHospital) references hospital(idHospital)
);


CREATE TABLE medida (
idMedida int primary key auto_increment,  -- IDENTITY(1,1),
percent_Memoria_Em_Uso decimal(5,2), -- long memoria.getemuso
uso_Cpu_Processo decimal(5,2), -- processo.getusocpu 
uso_Processador decimal(5,2), -- double processador.getuso
uso_Ram_Processo decimal(5,2), -- double processo.getUsoMemoria
percent_Uso_Disco decimal(5,2), -- long disco.getleituras
momento varchar (50), -- datetime default current_timestamp
fkMaquina int,
foreign key (fkMaquina) references maquina (idMaquina)
);"

echo Banco de dados Criado com Sucesso!


cd home/ubuntu/Desktop
git clone https://github.com/Grupo-9-SPTECH/APLICACAO_JAVA.git
git pull
cd APLICACAO_JAVA/tech-health-api-java/target/
java -jar tech-health-api-java-1.0-SNAPSHOT-jar-with-dependencies.jar