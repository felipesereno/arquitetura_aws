# arquitetura_aws
Este repositório contém a primeira atividade avaliativa do programa de estágio da Compass (PB 20/03/2023). Dentro da atividade proposta, o documeto a seguir é o que compreende a parte prática do exercício.
<h3>Requisitos do exercício</h3>
<h5>Requisitos AWS:</h5>
<ol>
Gerar uma chave pública para acesso ao ambiente;<br>
Criar 1 instância EC2 com o sistema operacional Amazon Linux 2 (Família t3.small,
16 GB SSD);<br>
Gerar 1 elastic IP e anexar à instância EC2;<br>
Liberar as portas de comunicação para acesso público: (22/TCP, 111/TCP e UDP,
2049/TCP/UDP, 80/TCP, 443/TCP).
</ol>
<h5>Requisitos no linux:</h5>
<ol>
Configurar o NFS entregue;<br>
Criar um diretorio dentro do filesystem do NFS com seu nome;<br>
Subir um apache no servidor - o apache deve estar online e rodando;<br>
Criar um script que valide se o serviço esta online e envie o resultado da validação
para o seu diretorio no nfs;<br>
O script deve conter - Data HORA + nome do serviço + Status + mensagem
personalizada de ONLINE ou offline;<br>
O script deve gerar 2 arquivos de saida: 1 para o serviço online e 1 para o serviço
OFFLINE;<br>
Preparar a execução automatizada do script a cada 5 minutos;<br>
Fazer o versionamento da atividade;<br>
Fazer a documentação explicando o processo de instalação do Linux.
</ol>
