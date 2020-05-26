#! /bin/bash

echo "Este script es para copiar los archivos necesarios "
echo "en la instalación de Oracle que se pide en la materia"
echo "sobre un sistema basado en Ubunu"
echo
echo "El script va a respaldar tus archivos originales y"
echo "a copiar mis archivos a donde van en tu equipo."
echo
echo "La instalación de Oracle va a seguir de manera manual, así que"
echo "en teoria solo deberias de seguir las instrucciones del manual."
echo
echo "En todo caso si no sabes que onda, buscame xD"

sudo cp ./linux.txt /linux.txt

echo "Si es la primera vez que ejecutas el script, dile que Y"
read -p "Respaldar archivos actuales? [Y/n]: " option
if [[ $option == "Y" || $option == "y" ]]
then
	echo "Respaldando archivos ..."
	mkdir -p ./respaldo
	cd ./respaldo
	sudo cp $ORACLE_HOME/bin/orald ./orald 
	sudo cp $ORACLE_HOME/rdbms/lib/ins_rdbms.mk ./ins_rdbms.mk
	sudo cp $ORACLE_HOME/rdbms/lib/env_rdbms.mk ./env_rdbms.mk
	sudo cp $ORACLE_HOME/plsql/lib/env_plsql.mk ./env_plsql.mk
	sudo cp $ORACLE_HOME/sqlplus/lib/env_sqlplus.mk ./env_sqlplus.mk
	sudo cp $ORACLE_HOME/network/lib/ins_net_server.mk ./ins_net_server.mk
	sudo cp $ORACLE_HOME/network/lib/env_network.mk ./env_network.mk
	cd ..
fi

echo "Eliminando archivos ..."
sudo rm -rf $ORACLE_HOME/bin/orald
sudo rm -rf $ORACLE_HOME/rdbms/lib/ins_rdbms.mk
sudo rm -rf $ORACLE_HOME/rdbms/lib/env_rdbms.mk
sudo rm -rf $ORACLE_HOME/plsql/lib/env_plsql.mk
sudo rm -rf $ORACLE_HOME/sqlplus/lib/env_sqlplus.mk
sudo rm -rf $ORACLE_HOME/network/lib/ins_net_server.mk
sudo rm -rf $ORACLE_HOME/network/lib/env_network.mk

echo "Copiando archivos ..."
cd ./buenos
sudo cp ./orald $ORACLE_HOME/bin/orald
sudo cp ./ins_rdbms.mk $ORACLE_HOME/rdbms/lib/ins_rdbms.mk
sudo cp ./env_rdbms.mk $ORACLE_HOME/rdbms/lib/env_rdbms.mk
sudo cp ./env_plsql.mk $ORACLE_HOME/plsql/lib/env_plsql.mk
sudo cp ./env_sqlplus.mk $ORACLE_HOME/sqlplus/lib/env_sqlplus.mk
sudo cp ./ins_net_server.mk $ORACLE_HOME/network/lib/ins_net_server.mk
sudo cp ./env_network.mk $ORACLE_HOME/network/lib/env_network.mk
cd ..

echo "Eliminando directorio de instalación temporal ..."
sudo rm -rf /u01/app/oraInventory/

echo "Asignando permisos a usuario oracle de nuevo ..."
cd /
sudo chown -R oracle:oinstall u01
sudo chmod -R 755 u01

echo "Cediendo permisos para la instalación en modo gráfico a otros usuarios ..."
sudo xhost +

echo
echo "Ya puedes comenzar la instalación de nuevo, desde esta parte:"
echo "su -l oracle"
echo "cd $ORACLE_HOME"
echo "./runInstaller"
echo

sudo cat ./linux.txt
sudo rm -rf ./linux.txt

#$ORACLE_HOME/bin/orald
#$ORACLE_HOME/rdbms/lib/ins_rdbms.mk
#$ORACLE_HOME/rdbms/lib/env_rdbms.mk
#$ORACLE_HOME/plsql/lib/env_plsql.mk
#$ORACLE_HOME/sqlplus/lib/env_sqlplus.mk
#$ORACLE_HOME/network/lib/ins_net_server.mk
#$ORACLE_HOME/network/lib/env_network.mk
