# arquitetura_aws

Este repositório contém a primeira atividade avaliativa do programa de estágio da Compass (PB 20/03/2023). Dentro da atividade proposta, o documento a seguir é o que compreende a parte prática do exercício, envolvendo conhecimentos em infraestrutura da Amazon Web Services (AWS) e Linux.

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

<h3>Execução dos requisitos do exercício</h3>

<h5>Gerando uma chave pública na AWS:</h5>
Este processo, refere-se a geração de um par de chaves no serviço de instâncias da AWS e, neste caso, é realizado através da console web.<br>
<ol>
  No console web da AWS, através do menu 'Serviços', no canto superior esquerdo, acesse o serviço de 'EC2' (Elastic Compute Cloud). O termo 'EC2' também pode ser buscado através da barra de pesquisa, no topo da página.<br>
  Na coluna esquerda, na sessão 'Redes e segurança', clique em 'Pares de chaves'.<br>
  <img src="prints_documentacao/par_de_chaves.png"><br>
  Para criar um par de chaves, clique no botão ('Criar par de chaves') com esta opção no canto superior direito da página.<br>
  Atribua um nome, selecione o tipo de par de chaves, o formato do arquivo (.pem para OpenSSH e .ppk para uso com Putty) e uma tag (opcional).<br>
  <img src="prints_documentacao/par_de_chaves1.png"><br>
  Após finalizar a operação, salve o arquivo baixado em local seguro.
</ol>

<h5>Criação de uma instância EC2:</h5>
Este processo, refere-se à criação de uma instâncias EC2 com o sistema operacional Amazon Linux 2 (Família t3.small,
16 GB SSD), neste caso, realizado através da console web.<br>
<ol>
  No console web da AWS, através do menu 'Serviços', no canto superior esquerdo, acesse o serviço de 'EC2' (Elastic Compute Cloud). O termo 'EC2' também pode ser buscado através da barra de pesquisa, no topo da página.<br>
  Na coluna esquerda, na sessão 'Instâncias', clique em 'Instâncias'.<br>
  <img src="prints_documentacao/instancias.png"><br>
  Para criar uma nova instância, clique no botão 'Executar instâncias' no topo da página.<br>
  Em 'Nome e tags', adicione um nome para a instância e tags (opcional).<br>
  Na seleção das imagens da aplicação, selecione o grupo 'Amazon Linux', especificamente 'Amazon Linux 2 Kernel 5.10 AMI 2.0.20230504.1 x86_64 HVM gp2'. O ID dessa AMI (Amazon Image) deve ser: ami-06a0cd9728546d178.<br>
  No 'Tipo de instância', selecione 't3.small'.<br>
  Na sessão 'Par de chaves (login)', selecione o par de chaves criado anteriormente, ou gere um novo par para atribuir a essa instância.<br>
  Na sessão 'Configurações de rede', marque a opção 'Criar grupo de segurança' e guarde o nome do grupo de segurança que será criado. Configurações específicas de rede para esse grupo serão feitas na documentação do próximo requisito.<br>
  Na sessão 'Configurar armazenamento', selecione 16GB, tipo gp2 de volume raiz.<br>
  Em 'Resumo', verifique as configurações selecionadas, certificando-se que o 'Número de instâncias' seja '1'. Clique no botão 'Executar instância'.<br>
</ol>

<h5>Gerar 1 elastic IP e anexar à instância EC2:</h5>

<h5>Liberar as portas de comunicação para acesso público:</h5>
Este processo, refere-se à configuração de regras de entrada no grupo de segurança criado anteriormente, neste caso, realizado através da console web. As regras de segurança são: 22/TCP, 111/TCP e UDP, 2049/TCP/UDP, 80/TCP, 443/TCP.<br>
<ol>
  No console web da AWS, através do menu 'Serviços', no canto superior esquerdo, acesse o serviço de 'EC2' (Elastic Compute Cloud). O termo 'EC2' também pode ser buscado através da barra de pesquisa, no topo da página.<br>
  Na coluna esquerda, na sessão 'Rede e segurança', clique em 'Security groups'.<br>
  <img src="prints_documentacao/grupo_de_seguranca.png"><br>
  Selecione o grupo de segurança criado anteriormente, clique no botão 'Ações' e 'Editar regras de entrada'.<br>
  <img src="prints_documentacao/regras_entrada.png"><br>
  
</ol>

<h5>Instalação do linux em uma máquina virtual:</h5>
Este processo, refere-se instalação da distribuição Oracle Linux 8.7 (sem interface gráfica), na Oracle VirtualBox 7.0, em uma máquina rodando o sistema operacional Windows 11.<br>
<ol>
  Baixe e siga o processo de instalação do host para Windows do <a href="https://www.virtualbox.org/wiki/Downloads">Oracle VirtualBox 7.0</a>.<br>
  Baixe o arquivo ISO completo da distribuição <a href="https://yum.oracle.com/oracle-linux-isos.html">Oracle Linux 8.7</a>.<br>
  No VirtualBox clique no ícone 'Novo'.<br>
  Use o campo 'Nome' para nomear a máquina virtual, selecione a imagem ISO baixada e marque a opção 'Pular instalação desassistida' se for o único a utilizar a instância criada.<br>
  <img src="prints_documentacao/criar_vm.png"><br>
  Ao clicar em 'Próximo', selecione a quantidade de memória RAM e número de núcleos de processamento a serem utilizados. Recomenda-se, aproximadamente, 2MB e 1 núcleo de CPU.<br>
  <img src="prints_documentacao/ram_cpu.png"><br>
  Ao clicar em 'Próximo', selecione a quantidade de armazenamento em disco a ser utilizado. Recomenda-se 'Criar um novo disco rígido agora' e selecionar a opção padrão '20GB'.<br>
  <img src="prints_documentacao/disco.png"><br>
  Ao clicar em 'Próximo', revise as especificações realizadas e clique em 'Finalizar'.<br>
  Para iniciar a máquina virtual criada, selecione-a na coluna a esquerda e clique no ícone 'Iniciar'.<br>
  Na interface gráfica de instalação, deve-se atentar a algumas configurações importantes, como linguagem do teclado (br), seleção do software (server), rede (seleção da interface caso a máquina conecte-se a internet), definição de senha para o root e criação de um usuário comum do sistema.<br>
  <img src="prints_documentacao/instalacao_linux1.png"><br>
  <img src="prints_documentacao/instalacao_linux2.png"><br>
  Depois de revisar as configurações, clique em 'Begin Installation'.<br>
  Finalizado o processo de instalação, clique em 'Reboot System'.<br>
  <img src="prints_documentacao/instalacao_linux3.png"><br>
</ol>
