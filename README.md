<h1>arquitetura_aws</h1>
Este repositório contém a primeira atividade avaliativa do programa de estágio da Compass.UOL (PB 20/03/2023). Dentro da atividade proposta, o documento a seguir é o que compreende a parte prática do exercício, envolvendo conhecimentos em infraestrutura da Amazon Web Services (AWS) e Linux.<br><br>

<h2>Tabela de conteúdos</h2>
<ul>
  <li><a href="#req_exercicio">Requisitos do exercício</a><br>
  <li><a href="#exe_exercicio">Executando os requisitos do exercício</a><br>
  <ul>
    <li><a href="#chave_publica">Gerando uma chave pública para acesso ao ambiente da AWS</a><br>
    <li><a href="#ec2_web">Criando uma instância EC2 pela console web da AWS</a><br>
    <li><a href="#ec2_cli">Criando uma instância EC2 pela AWS CLI</a><br>
    <li><a href="#ip_elastico">Gerando um IP elástico e anexando à instância EC2</a><br>
    <li><a href="#portas">Liberando as portas de comunicação da instância EC2 para acesso público</a><br>
    <li><a href="#nfs">Configurando um Network File System (NFS)</a><br>
    <li><a href="#servidor_apache">Criando um servidor Apache</a><br>
    <li><a href="#status_apache">Criando um script de verificação do status do serviço Apache</a><br>
    <li><a href="#script">Preparando a execução automatizada do script a cada 5 minutos</a><br>
    <li><a href="#inst_linux">Instalando uma máquina virtual com sistema Linux</a><br>
    <li><a href="#extra">Seção extra: Gerando um par de chaves para acesso à instância e transferência para a máquina virtual</a><br>
  </ul>
</ul><br>

<div id="req_exercicio"><h2>Requisitos do exercício</h2><div>
<h4>Requisitos AWS:</h4>
<ul>
  <li>Gerar uma chave pública para acesso ao ambiente;<br>
  <li>Criar uma instância EC2 com sistema operacional Amazon Linux 2 (Família t3.small,
16 GB SSD);<br>
  <li>Gerar um IP elástico e anexar à instância EC2;<br>
  <li>Liberar as portas de comunicação para acesso público: 22/TCP, 111/TCP e UDP,
2049/TCP/UDP, 80/TCP, 443/TCP.
</ul>
<h4>Requisitos no linux:</h4>
<ul>
  <li>Configurar o NFS entregue;<br>
  <li>Criar um diretório dentro do filesystem do NFS com seu nome;<br>
  <li>Subir um apache no servidor - o apache deve estar online e rodando;<br>
  <li>Criar um script que valide se o serviço está online e envie o resultado da validação
para o seu diretório no nfs;<br>
  <li>O script deve conter - Data HORA + nome do serviço + status + mensagem
personalizada de ONLINE ou offline;<br>
  <li>O script deve gerar 2 arquivos de saída: 1 para o serviço online e 1 para o serviço
offline;<br>
  <li>Preparar a execução automatizada do script a cada 5 minutos;<br>
  <li>Fazer o versionamento da atividade;<br>
  <li>Fazer a documentação explicando o processo de instalação do Linux.
</ul>

<div id="exe_exercicio"><h2>Executando os requisitos do exercício</h2><div>
<div id="chave_publica"><h4>Gerando uma chave pública para acesso ao ambiente da AWS:</h4><div>
Este processo refere-se à geração de um usuário e grupo, configuração de suas políticas e criação de uma chave para acesso à conta.<br>
<ol>
  <li>No console web da AWS, através do menu 'Serviços', no canto superior esquerdo, acesse o serviço de 'IAM' (Identity and Access Management). O termo 'IAM' também pode ser buscado através da barra de pesquisa, no topo da página.<br>
  <li>Na coluna esquerda, na seção 'Gerenciamento de acesso', clique em 'Grupos de usuários'.<br>
  <li>Clique em ‘Criar grupo’.<br>
  <li>Atribua um nome ao novo grupo e na seção ‘Associar políticas de permissões’ marque a opção ‘AdministratorAccess’. Clique em ‘Criar grupo’. Essa política concede acesso de administrador aos usuários que forem adicionados a esse grupo.<br>
  <li>Para criar um novo usuário e adicioná-lo ao grupo criado, clique em ‘Usuários’, na seção ‘Gerenciamento de acesso’ na coluna esquerda, ainda no serviço de IAM.<br>
  <li>Clique em ‘Adicionar usuários’.<br>
  <li>Adicione um nome para o usuário criado e clique em ‘Próximo’.<br>
  <li>Nas ‘Opções de permissões’, selecione ‘Adicionar usuário ao grupo’. Na seção ‘Grupos de usuários’, selecione o grupo criado anteriormente e clique em ‘Próximo’.<br>
  <li>Revise as configurações e clique em ‘Criar usuário’.<br>
  <li>Para gerar uma chave pessoal basta clicar em  ‘Usuários’, na seção ‘Gerenciamento de acesso’ na coluna esquerda, ainda no serviço de IAM.<br>
  <li>Clique no nome do usuário criado anteriormente.<br>
  <li>Na página do usuário, abaixo da seção ‘Resumo’, clique na aba ‘Credenciais de segurança’. Em ‘Chaves de acesso’, clique em ‘Criar chave de acesso’.<br>
  <li>Marque a opção ‘Command Line Interface (CLI)’ e, no fim da página, ‘Compreendo a recomendação acima e quero prosseguir para criar uma chave de acesso’. Clique em ‘Próximo’.<br>
  <li>Defina uma etiqueta de descrição (opcional) e clique em ‘Criar chave de acesso’.<br>
  <li>Armazene a ‘Chave de acesso’ e a ‘Chave de acesso secreta’, ou baixe o arquivo ‘.csv’ e clique em ‘Concluído’.<br>
</ol>

<div id="ec2_web"><h4>Criando uma instância EC2 pela console web da AWS:</h4><div>
Este processo refere-se à criação de uma instância EC2 com o sistema operacional Amazon Linux 2 (família t3.small e
16 GB de armazenamento SSD).<br>
<ol>
  <li>No console web da AWS, através do menu 'Serviços', no canto superior esquerdo, acesse o serviço de 'EC2'. O termo 'EC2' também pode ser buscado através da barra de pesquisa, no topo da página.<br>
  <li>Na coluna esquerda, na sessão 'Instâncias', clique em 'Instâncias'.<br>
  <li>Para criar uma nova instância, clique no botão 'Executar instâncias' no topo da página.<br>
  <li>Em 'Nome e tags', adicione um nome para a instância e tags (opcional).<br>
  <li>Na seleção das imagens da aplicação, selecione o grupo 'Amazon Linux', especificamente 'Amazon Linux 2 Kernel 5.10 AMI 2.0.20230504.1 x86_64 HVM gp2'. O ID dessa AMI (Amazon Image) deve ser: ami-06a0cd9728546d178.<br>
  <li>No 'Tipo de instância', selecione 't3.small'.<br>
  <li>Na sessão 'Par de chaves (login)', gere um novo par de chaves para acessar essa instância, ou selecione uma chave existente.<br>
  <lil>Para gerar um novo par de chaves, clique no botão 'Criar novo par de chaves'. Atribua um nome, selecione o tipo, o formato do arquivo (.pem para OpenSSH e .ppk para uso com Putty) e uma tag (opcional). Após finalizar a operação, salve o arquivo baixado em local seguro.<br>
  <li>Na seção 'Configurações de rede', marque a opção 'Criar grupo de segurança', ou selecione um grupo já existente. Configurações específicas de rede para esse grupo serão feitas no requisito '<a href="#portas">Liberando as portas de comunicação da instância EC2 para acesso público</a>'.<br>
  <li>Na sessão 'Configurar armazenamento', selecione 16GB, tipo gp2 de volume raiz.<br>
  <li>Em 'Resumo', verifique as configurações selecionadas, certificando-se que o 'Número de instâncias' seja '1'. Clique no botão 'Executar instância'.<br>
</ol>

<div id="ec2_cli"><h4>Criando uma instância EC2 pela AWS CLI:</h4><div>
De forma alternativa à seção '<a href="#ec2_web">Criando uma instância EC2 pela console web da AWS</a>', o processo referenciado aqui compreende à geração da mesma instância, porém, através da interface de linha de comando (CLI) da AWS. Para atender esse requisito as seguintes etapas serão necessárias: configuração da CLI, geração de um usuário e grupo, configuração de suas políticas, criação de uma chave para acesso à conta e, por fim, execução da instância. 
<ol>
  <li>Em um terminal linux, digite o comando <code>sudo yum update</code> para atualizar todos os pacotes do sistema.<br>
  <li>Baixe a CLI digitando <code>curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"</code>. Para mais informações sobre como fazer a instalação acesse a documentação da <a href="https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#cliv2-linux-install">AWS CLI</a>.<br>
  <li>Descompacte o arquivo baixado digitando <code>unzip awscliv2.zip</code>. Se o comando não funcionar, instale os pacotes correspondentes ao serviço unzip utilizando o comando <code>sudo yum install unzip</code>. Depois tente descompactar o arquivo novamente.<br>
  <li>Instale a CLI digitando o comando <code>sudo ./aws/install</code>.<br>
  <li>Após a instalação, certifique-se que o sistema consegue identificar o programa inserindo o comando <code>aws --v</code>. O retorno deve informar a versão de tudo o que foi instalado.<br>
  <li>Para efetuar o acesso aos serviços da AWS através da CLI, antes é necessário gerar uma chave pessoal, que deve, posteriormente, ser informada nas configurações da interface. Como é preciso que se faça a atribuição de políticas de acesso para que o usuário, através de sua chave pessoal, execute os serviço, recomenda-se criar um grupo, atribuir políticas a ele e incluir esse usuário ao grupo. Este processo está documentado na seção '<a href="#chave_publica">Gerando uma chave pública para acesso ao ambiente da AWS</a>'.<br>
  <li>Para configurar a CLI, digite, em um terminal linux, <code>aws configure</code>, informando o ID e chave de acesso secreta vinculada à conta, o código da região que se pretende manipular os serviços e o formato do retorno dos dados (recomenda-se json).<br>
  <li>O processo de execução de uma instância pode ser feito através do comando <code>aws ec2 run-instances --image-id ami-06a0cd9728546d178  --count 1 --instance-type t3.small --key-name nome_da_chave --block-device-mappings '[{"DeviceName":"/dev/xvda","Ebs":{"VolumeSize":16,"VolumeType":"gp2"}}]' --tag-specifications 'ResourceType=instance,Tags=[{Key="Name",Value="Nome da instância"}]'</code>. O comando deve ser executado no diretório que contém o arquivo do par de chaves (nome_da_chave).<br>
  <li>Se o par de chaves ainda foi gerado, veja '<a href="#extra">Seção extra: Gerando um par de chaves para acesso à instância e transferência para a máquina virtual</a>'.<br>
</ol>

<div id="ip_elastico"><h4>Gerando um IP elástico e anexando à instância EC2:</h4><div>
Este processo refere-se à geração de um IP elástico e sua associação à uma instância EC2, neste caso, realizado através do console web.
<ol>
  <li>No console web da AWS, através do menu 'Serviços', no canto superior esquerdo, acesse o serviço de 'EC2'. O termo 'EC2' também pode ser buscado através da barra de pesquisa, no topo da página.<br>
  <li>Na coluna esquerda, na sessão 'Redes e segurança', clique em 'IPs elásticos'.<br>
  <li>Clique no botão 'Alocar endereço IP elástico', marque a opção 'Conjunto de endereços IPv4 da Amazon' e clique em 'Alocar'. Pode ser necessário especificar o grupo de borda de rede que deve ser a mesma região onde foi criada a instância.<br>
  <li>Para associar o IP alocado à uma instância em execução selecione-o no painel de IPs, clique em 'Ações' e selecione a opção 'Associar endereço IP elástico'.<br>
  <li>Selecione 'Instância' no 'Tipo de recurso', escolha a instância que terá o IP associado e clique em 'Associar'.
</ol>

<div id="portas"><h4>Liberando as portas de comunicação da instância EC2 para acesso público:</h4><div>
Este processo refere-se à configuração de regras de entrada no grupo de segurança associado à instância, neste caso, realizado através do console web. As regras de segurança são: 22/TCP, 111/TCP e UDP, 2049/TCP/UDP, 80/TCP, 443/TCP.<br>
<ol>
  <li>No console web da AWS, através do menu 'Serviços', no canto superior esquerdo, acesse o serviço de 'EC2'. O termo 'EC2' também pode ser buscado através da barra de pesquisa, no topo da página.<br>
  <li>Na coluna esquerda, na seção 'Rede e segurança', clique em 'Security groups'.<br>
  <li>Selecione o grupo de segurança criado anteriormente, clique no botão 'Ações' e 'Editar regras de entrada'.<br>
  <li>Clique em 'Adicionar regra' ao inserir os dados de cada linha da tabela abaixo.<br><br>
  <table>
    <thead>
      <tr>
        <th>Tipo</th>
        <th>Intervalo de portas</th>
        <th>Tipo de origem</th>
    </thead>
    <tbody>
      <tr>
        <td>TCP personalizado</td>
        <td>22</td>
        <td>Qualquer local-IPv4</td>
      </tr>
      <tr>
        <td>TCP personalizado</td>
        <td>111</td>
        <td>Qualquer local-IPv4</td>
      </tr>
      <tr>
        <td>UDP personalizado</td>
        <td>111</td>
        <td>Qualquer local-IPv4</td>
      </tr>
      <tr>
        <td>TCP personalizado</td>
        <td>2049</td>
        <td>Qualquer local-IPv4</td>
      </tr>
      <tr>
        <td>UDP personalizado</td>
        <td>2049</td>
        <td>Qualquer local-IPv4</td>
      </tr>
      <tr>
        <td>TCP personalizado</td>
        <td>80</td>
        <td>Qualquer local-IPv4</td>
      </tr>
      <tr>
        <td>TCP personalizado</td>
        <td>443</td>
        <td>Qualquer local-IPv4</td>
      </tr>
    </tbody>
    </table>
  <li>Após inseridas as 7 regras de entrada, clique em 'Salvar regras'.<br>
</ol>

<div id="nfs"><h4>Configurando um Network File System (NFS):</h4><div>
Este processo refere-se à criação de um NFS na instância EC2 executada anteriormente.<br>
<ol>
  <li>No console web da AWS, através do menu 'Serviços', no canto superior esquerdo, acesse o serviço de 'EFS' (Elastic File System). O termo 'EFS' também pode ser buscado através da barra de pesquisa, no topo da página.<br>
  <li>Na coluna esquerda, clique em 'Sistemas de arquivos'. Depois, em ‘Criar sistema de arquivos’, no topo da página.<br>
  <li>Atribua um nome (opcional), selecione a Virtual Private Cloud (VPC) e clique em ‘Criar’.<br>
  <li>Nas informações do EFS criado, clique na aba ‘Rede’, logo abaixo da seção ‘Geral’. Clique em ‘Gerenciar’.<br>
  <li>Na seção ‘Destinos de montagem’, troque o grupo de segurança para o mesmo utilizado pela instância, para todas as zonas de disponibilidade listadas. Clique em ‘Salvar’.<br> 
  <li>Ainda na página de informações do NFS criado, clique em ‘Anexar’.<br>
  <li>Com a opção ‘Montar via DNS’ selecionada, copie o comando que aparece na seção ‘Usando o cliente do NFS:’. Um exemplo desse comando é: <code>sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-0cf1d041dea5dc917.efs.us-east-1.amazonaws.com:/ efs</code>.<br>
  <li>No terminal da instância, crie um diretório que vai ser montado para receber os arquivos compartilhados. Para isso, use o comando <code>mkdir /home/ec2-user/nfs</code>. Neste exemplo, o diretório a ser montado é <code>nfs/</code> no caminho <code>/home/ec2-user</code><br>
  <li>Execute o comando <code>sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-0cf1d041dea5dc917.efs.us-east-1.amazonaws.com:/ /home/ec2-user/nfs</code>.<br>
  <li>Executando o comando <code>df -h</code>, deve-se ver o diretório montado corretamente. Aqui está um exemplo:<br><br>
<table>
  <thead>
    <tr>
      <th>Filesystem</th>
      <th>Size</th>
      <th>Used</th>
      <th>Avail</th>
      <th>Use%</th>
      <th>Mounted on</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>fs-0cf1d041dea5dc917.efs.us-east-1.amazonaws.com:/</td>
      <td>8.0E</td>
      <td>0</td>
      <td>8.0E</td>
      <td>0%</td>
      <td>/home/ec2-user/efs</td>
    </tr>
  </tbody>
</table>
  <li>Por fim, para criar um diretório com o seu nome dentro do NFS criado execute o comando <code>sudo mkdir /home/ec2-user/nfs/seu_nome</code>.<br>
</ol>

<div id="servidor_apache"><h4>Criando um servidor Apache:</h4><div>
Este processo refere-se à instalação de um servidor Apache na instância EC2 criada anteriormente.<br>
<ol>
  <li>No terminal Linux, execute o comando <code>sudo yum update</code> para atualizar os pacotes instalados no sistema.<br>
  <li>Instale os pacotes do Apache usando o comando <code>sudo yum install httpd</code>.<br>
  <li>Para iniciar o servidor digite <code>sudo systemctl start httpd</code>.<br>
  <li>Para verificar se o serviço está ativo utiliza-se o comando <code>systemctl status httpd</code>. O status deve estar ativo.<br>
  <li>Outra forma de verificar a disponibilidade do servidor é informando o endereço IP da instância na barra URL do navegador. Uma página de testes do Apache deve aparecer.<br>
</ol>

<div id="status_apache"><h4>Criando um script de verificação do status do serviço Apache:</h4><div>
Este processo refere-se à criação de um 'shell script' que tem a função de automatizar a verificação do status do serviço Apache gerado anteriormente.<br>
<ol>
  <li>Para inserir o script na instância, execute o comando <code>touch /home/ec2-user/apache_status.sh</code>. Edite o arquivo criado digitando <code>vim /home/ec2-user/apache_status.sh</code> e cole o conteúdo do script presente neste repositório.<br>
  <li>O arquivo <code>apache_status.sh</code>, tem a função de verificar o status do serviço <code>httpd</code>(Apache) e armazenar mensagens de log no diretório <code>/nfs</code>.<br>
  <li>O script possui a funcionalidade de criar os arquivos de log, caso ainda não existam, e adicionar a mensagem "Data-hora (fuso horário de São Paulo) + APACHE + ONLINE + SERVIDOR WEB ATIVO.", caso o serviço esteja ativo, e "Data-hora (fuso horário de São Paulo) + APACHE + OFFLINE + SERVIDOR WEB INATIVO.", caso contrário.<br>
</ol>
    
<div id="script"><h4>Preparando a execução automatizada do script a cada 5 minutos:</h4><div>
Este processo refere-se à execução automatizada do <code>apache_status.sh</code> a cada 5 minutos.<br>
<ol>
  <li>Execute o comando <code>sudo crontab -e</code> para abrir, em modo de edição, o arquivo que armazena os scripts de automatização do sistema.<br>
  <li>Clique na letra <code>i</code> para ativar a função de inserção e adicione o comando: <code>*/5 * * * * /bin/bash caminho_do_script.sh</code>. Neste caso, o caminho do script é <code>/home/ec2-user/apache_status.sh</code>.<br>
  <li>Execute o comando <code>sudo systemctl restart crond</code>, para reiniciar o serviço de automatização. Agora o script <code>apache_status.sh</code> deve ser executado automaticamente a cada 5 minutos.<br>
</ol>

<div id="inst_linux"><h4>Instalando uma máquina virtual com sistema Linux:</h4><div>
Este processo refere-se à instalação da distribuição Oracle Linux 8.7 (sem interface gráfica), na Oracle VirtualBox 7.0, em uma máquina rodando o sistema operacional Windows 11.<br>
<ol>
  <li>Baixe e siga o processo de instalação do host para Windows do <a href="https://www.virtualbox.org/wiki/Downloads">Oracle VirtualBox 7.0</a>.<br>
  <li>Baixe o arquivo ISO completo da distribuição <a href="https://yum.oracle.com/oracle-linux-isos.html">Oracle Linux 8.7</a>.<br>
  <li>No VirtualBox clique no ícone 'Novo'.<br>
  <li>Use o campo 'Nome' para nomear a máquina virtual, selecione a imagem ISO baixada e marque a opção 'Pular instalação desassistida' se for o único a utilizar a instância criada.<br>
  <li>Ao clicar em 'Próximo', selecione a quantidade de memória RAM e número de núcleos de processamento a serem utilizados. Recomenda-se, aproximadamente, 2MB e 1 núcleo de CPU.<br>
  <li>Ao clicar em 'Próximo', selecione a quantidade de armazenamento em disco a ser utilizado. Recomenda-se 'Criar um novo disco rígido agora' e selecionar a opção padrão '20GB'.<br>
  <li>Ao clicar em 'Próximo', revise as especificações realizadas e clique em 'Finalizar'.<br>
  <li>Para iniciar a máquina virtual criada, selecione-a na coluna a esquerda e clique no ícone 'Iniciar'.<br>
  <li>Na interface gráfica de instalação, deve-se atentar a algumas configurações importantes, como linguagem do teclado (br), seleção do software (server), rede (seleção da interface caso a máquina conecte-se a internet), definição de senha para o root e criação de um usuário comum do sistema.<br>
  <li>Depois de revisar as configurações, clique em 'Begin Installation'.<br>
  <li>Finalizado o processo de instalação, clique em 'Reboot System'.<br>
  <li>Por último, recomenda-se colocar a interface de rede da máquina virtual em modo bridge (ponte). Para isso, no gerenciador de virtualizações do VirtualBox (página inicial do programa), selecione a máquina que deseja alterar as configurações na coluna esquerda. Clique em 'Configurações', no topo da página. Na janela de configurações, selecine a seção 'Rede', na coluna esquerda. Na aba 'Adaptador 1', com a caixa de seleção 'Habilitar Placa de Rede' marcada, selecine 'Placa em modo Bridge', na seção 'Conectado a:'. Clique em 'Ok' para salvar a alteração. Agora, a máquina pode ser iniciada com a nova configuração.<br>
</ol>
  
<div id="extra"><h4>Seção extra: Gerando um par de chaves para acesso à instância e transferência para a máquina virtual:</h4><div>
Este processo refere-se à geração de um par de chaves no serviço EC2 e transferência do arquivo para a máquina virtual com linux.<br>
<ol>
  <li>No console web da AWS, através do menu 'Serviços', no canto superior esquerdo, acesse o serviço de 'EC2' (Elastic Compute Cloud). O termo 'EC2' também pode ser buscado através da barra de pesquisa, no topo da página.<br>
  <li>Na coluna esquerda, na sessão 'Redes e segurança', clique em 'Pares de chaves'.<br>
  <li>Para criar um par de chaves, clique no botão ('Criar par de chaves') no canto superior direito da página.<br>
  <li>Atribua um nome, selecione o tipo de par de chaves, o formato do arquivo (.pem para OpenSSH e .ppk para uso com Putty) e uma tag (opcional).<br>
  <li>Após finalizar a operação, salve o arquivo baixado em local seguro.
  <li>Para tranferir o arquivo baixado do sistema Windows para a máquina virtual com Linux, digite, no terminal PowerShell, o comando <code>scp C:\caminho\chave\no\windows usuário_linux@ipv4_público_linux:/caminho/destino/linux</code>.<br>
</ol>

