Mini instruction for deploy

This project is designed to deploy all bbsoft services on bbsoft clusters
To run CI CD, you need to set 3 env
PROJECT
SERVICE
BRANCH
All this env must be upper case
Now you can deploy only in bbsoft-dev (into google). In a future will be add another clusters

The name of the clusters (PROJECT) is gcp-dev in this case gcp is the designation that the deployment will be in Google, and dev is the dev cluster (bbsoft-dev)
dc-preprod will be implemented soon - dc is a data center, preprod is the same cluster as toloto
Prod cluster will be dc-prod and if it is in Google - gcp-prod
BRANCH - the branch  which you want to deploy
SERVICE - the name of repo that you want to deploy ( for example unity-games or bbsoft-client )

by the end deploy should be look like
1)Go to tab CI\CD
2)Press Run pipeline
3)Set 3 env (example)
PROJECT      gcp-dev
SERVICE      unity-games
BRANCH       dev



Мини инструкция для деплоя.

Весь этот проект предназачен для деплоя всех сервисов ббсофта на кластера ббсофта
Для запуска CI CD необходимо указать 3 энва
PROJECT
SERVICE
BRANCH
все энвы вводить большими буквами
сейчас реализован деплой в гугл проект bbsoft-dev в гугле. В будущем будут добавлены все осотальные кластера


название кластеров (PROJECT) - gcp-dev    в данном случае gcp - обозначение, что деплой будет в гугл, а dev - дев кластер (bbsoft-dev)
в скором времени будет реализован dc-preprod - dc - это data center (ЦОД) , preprod - тот же кластер, что и толото
Прод кластер соответственно будет dc-prod и если будет в гугле - gcp-prod

BRANCH - соответственно бранча, с которой мы хотим деплоить
и SERVICE - название репы, которую деплоим, например unity-games или bbsoft-client. 

По итогу деплой выглядит следущим образом (пример)
1)Переходим во вкладку CI/CD
2)Жмем Run pipline
3)Выбираем 3 энва
PROJECT      gcp-dev
SERVICE      unity-games
BRANCH       dev
