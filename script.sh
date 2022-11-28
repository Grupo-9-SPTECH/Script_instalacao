#!/bin/bash

# instalando interface grafica
echo "Deseja instalar a interface gráfica? (s/n)"
read inst

if [ \"$inst\" == \"s\" ];
then
		sudo apt-get install xrdp lxde-core lxde tigervnc-standalone-server -y
		#git clone https://github.com/Grupo-9-SPTECH/APLICACAO_JAVA.git swing
else
		echo "Atualizando Pacotes"
		#git clone https://github.com/Grupo-9-SPTECH/APLICACAO_JAVA.git terminal
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
    echo "Gostaria de instalar o Docker e Banco TechHealth? (s/n)"
    read inst
    if [ \"$inst\" == \"s\" ];
    then
        sudo apt install docker.io -y

        echo "Iniciando Aplicação TechHealth"
        echo "Caminho: "
        pwd

        sudo docker pull mysql:5.7
        sudo systemctl start docker
        sudo systemctl enable docker
        sudo docker-compose up -d
        sudo docker start CONTAINER_GRUPO9

        sudo docker exec -it $(sudo docker ps -aqf "name=containerDB") mysql -u root -p -B -N -e "
        create database grupo9;
            use grupo9;

	CREATE TABLE hospital (
	idHospital int primary key auto_increment, -- IDENTITY(1,1),
	nome_Hospital varchar (45),
	cnpj varchar(45),
	endereco varchar (100),
    bairro varchar (100),
    cidade varchar (100),
    UF char(2)
	);
    

create table usuario (
id int primary key auto_increment, -- IDENTITY(1,1),
nome varchar (45),
cnpj varchar (45),
email varchar (45),
check (email like '%@%' and email like '%.com%'),
senha varchar (45)
);



CREATE TABLE maquina (
idMaquina int primary key auto_increment, -- IDENTITY(1,1),
ala_Hospitalar varchar (45), -- inserir manualmente
sistema_Operacional varchar (100), -- sistema.getSistema
fabricante varchar (45), -- sistema.getfabricante
nome_Processador varchar (100), -- processador get.nome
frequencia_Processador decimal (10,2), -- frequencia do processador processador.getfrequencia
capacidade_Total_Memoria decimal(10,2), -- memoria.gettotal
tamanho_Disco decimal(10,2), -- long disco.gettamanho
numero_CPU_fisica int, -- processador.getnumeroscpusfisicas
fkHospital int,
foreign key (fkHospital) references hospital(idHospital)
);


CREATE TABLE medida (
idMedida int primary key auto_increment,  -- IDENTITY(1,1),
percent_Memoria_Em_Uso decimal(10,2), -- long memoria.getemuso
uso_Cpu_Processo decimal(10,2), -- processo.getusocpu 
uso_Processador decimal(10,2), -- double processador.getuso
uso_Ram_Processo decimal(10,2), -- double processo.getUsoMemoria
percent_Uso_Disco decimal(10,2), -- long disco.getleituras
momento varchar (50), -- datetime default current_timestamp
fkMaquina int,
foreign key (fkMaquina) references maquina (idMaquina)
);
 "
            echo Banco de dados Criado com Sucesso!
    fi
fi

wget https://github.com/Grupo-9-SPTECH/APLICACAO_JAVA/raw/main/tech-health-api-java/target/tech-health-api-java-1.0-SNAPSHOT-jar-with-dependencies.jar


sudo docker build -t dockerfile .
sudo docker run  -d -t --name tech-health-java dockerfile
java -jar tech-health-api-java-1.0-SNAPSHOT-jar-with-dependencies.jar

