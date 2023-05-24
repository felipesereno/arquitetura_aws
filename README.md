# arquitetura_aws

Este repositório contém a primeira atividade avaliativa do programa de estágio da Compass (PB 20/03/2023). Dentro da atividade proposta, o documento a seguir é o que compreende a parte prática do exercício, envolvendo conhecimentos em infraestrutura da Amazon Web Services (AWS) e Linux.

<h3>Requisitos do exercício</h3>
<h5>Requisitos AWS:</h5>
<ul>
<li>Gerar uma chave pública para acesso ao ambiente;<br>
<li>Criar 1 instância EC2 com o sistema operacional Amazon Linux 2 (Família t3.small,
16 GB SSD);<br>
<li>Gerar 1 elastic IP e anexar à instância EC2;<br>
<li>Liberar as portas de comunicação para acesso público: (22/TCP, 111/TCP e UDP,
2049/TCP/UDP, 80/TCP, 443/TCP).
</ul>
<h5>Requisitos no linux:</h5>
<ul>
<li>Configurar o NFS entregue;<br>
<li>Criar um diretório dentro do filesystem do NFS com seu nome;<br>
<li>Subir um apache no servidor - o apache deve estar online e rodando;<br>
<li>Criar um script que valide se o serviço está online e envie o resultado da validação
para o seu diretório no nfs;<br>
<li>O script deve conter - Data HORA + nome do serviço + Status + mensagem
personalizada de ONLINE ou offline;<br>
<li>O script deve gerar 2 arquivos de saída: 1 para o serviço online e 1 para o serviço
OFFLINE;<br>
<li>Preparar a execução automatizada do script a cada 5 minutos;<br>
<li>Fazer o versionamento da atividade;<br>
<li>Fazer a documentação explicando o processo de instalação do Linux.
</ul>

<h3>Execução dos requisitos do exercício</h3>

<h5>Gerando uma chave pública na AWS:</h5>
Este processo refere-se a geração de um par de chaves no serviço de instâncias da AWS e, neste caso, é realizado através da console web.<br>
<ol>
  <li>No console web da AWS, através do menu 'Serviços', no canto superior esquerdo, acesse o serviço de 'EC2' (Elastic Compute Cloud). O termo 'EC2' também pode ser buscado através da barra de pesquisa, no topo da página.<br>
  <li>Na coluna esquerda, na sessão 'Redes e segurança', clique em 'Pares de chaves'.<br>
  <li>Para criar um par de chaves, clique no botão ('Criar par de chaves') no canto superior direito da página.<br>
  <li>Atribua um nome, selecione o tipo de par de chaves, o formato do arquivo (.pem para OpenSSH e .ppk para uso com Putty) e uma tag (opcional).<br>
  <li>Após finalizar a operação, salve o arquivo baixado em local seguro.
</ol>

<h5>Criação de uma instância EC2:</h5>
Este processo refere-se à criação de uma instância EC2 com o sistema operacional Amazon Linux 2 (Família t3.small,
16 GB SSD), neste caso, realizado através da console web.<br>
<ol>
  <li>No console web da AWS, através do menu 'Serviços', no canto superior esquerdo, acesse o serviço de 'EC2' (Elastic Compute Cloud). O termo 'EC2' também pode ser buscado através da barra de pesquisa, no topo da página.<br>
  <li>Na coluna esquerda, na sessão 'Instâncias', clique em 'Instâncias'.<br>
  <li>Para criar uma nova instância, clique no botão 'Executar instâncias' no topo da página.<br>
  <li>Em 'Nome e tags', adicione um nome para a instância e tags (opcional).<br>
  <li>Na seleção das imagens da aplicação, selecione o grupo 'Amazon Linux', especificamente 'Amazon Linux 2 Kernel 5.10 AMI 2.0.20230504.1 x86_64 HVM gp2'. O ID dessa AMI (Amazon Image) deve ser: ami-06a0cd9728546d178.<br>
  <li>No 'Tipo de instância', selecione 't3.small'.<br>
  <li>Na sessão 'Par de chaves (login)', selecione o par de chaves criado anteriormente, ou gere um novo par para atribuir a essa instância.<br>
  <li>Na seção 'Configurações de rede', marque a opção 'Criar grupo de segurança' e guarde o nome que será criado. Configurações específicas de rede para esse grupo serão feitas no requisito 'Liberar as portas de comunicação para acesso público'.<br>
  <li>Na sessão 'Configurar armazenamento', selecione 16GB, tipo gp2 de volume raiz.<br>
  <li>Em 'Resumo', verifique as configurações selecionadas, certificando-se que o 'Número de instâncias' seja '1'. Clique no botão 'Executar instância'.<br>
</ol>

<h5>Criação de uma instância EC2 - AWS CLI</h5>
Este processo refere-se à criação de uma instância EC2 com o sistema operacional Amazon Linux 2 (Família t3.small, 16 GB SSD). Para atender esse requisito, as seguintes etapas serão necessárias: configuração da interface de linha de comando (CLI) da AWS, geração de um usuário, de um grupo e configuração de suas políticas, criação de uma chave secreta para acesso à conta e, por fim, execução de uma instância EC2. 
<ol>
<li>Em um terminal linux, digite o comando <code>sudo yum update</code> para garantir que todos os pacotes do sistema estejam atualizados.<br>
<li>Baixe a interface de linha de comando da AWS digitando <code>curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"</code>.<br>
<li>Descompacte o arquivo baixado digitando <code>unzip awscliv2.zip</code>. Se o comando não funcionar, instale os pacotes correspondentes ao serviço unzip utilizando o comando <code>sudo yum install unzip</code>. Depois tente descompactar o arquivo novamente.<br>
<il>Instale a CLI digitando o comando <code>sudo ./aws/install</code>.<br>
<li>Após a instalação, certifique-se que o sistema consegue identificar o programa adicionado com o comando <code>aws --v</code>. O retorno deve informar a versão de tudo o que foi instalado.<br>
<li>Para efetuar o acesso aos serviços da AWS através da CLI, antes é necessário gerar uma chave pessoal, que deve, posteriormente, ser informada nas configurações da CLI. Como é necessário que se faça a atribuição de políticas de acesso para que o usuário, através de sua chave pessoal, execute os serviço, recomenda-se criar um grupo, atribuir políticas a ele e incluir esse usuário ao grupo.<br>
<li>Na console web da AWS, através do menu 'Serviços', no canto superior esquerdo, acesse o serviço de 'IAM' (Identity and Access Management). O termo 'IAM' também pode ser buscado através da barra de pesquisa, no topo da página.<br>
<li>Na coluna esquerda, na seção 'Gerenciamento de acesso', clique em 'Grupos de usuários'.<br>
<li>Clique em ‘Criar grupo’.<br>
<li>Atribua um nome ao novo grupo e na seção ‘Associar políticas de permissões’ filtre pela palavra ‘EC2’ e marque a opção ‘AmazonEC2FullAccess’. Clique em ‘Criar grupo’.<br>
<li>Para criar um novo usuário e adicioná-lo ao grupo criado, clique em ‘Usuários’, na seção ‘Gerenciamento de acesso’, na coluna esquerda, ainda no serviço de IAM.<br>
<li>Clique em ‘Adicionar usuários’.<br>
<li>Adicione um nome para o usuário criado e clique em ‘Próximo’.<br>
<li>Nas ‘Opções de permissões’, selecione ‘Adicionar usuário ao grupo’. Na seção ‘Grupos de usuários’, selecione o grupo criado anteriormente e clique em ‘Próximo’.<br>
<li>Revise as configurações e clique em ‘Criar usuário’.<br>
<li>Para gerar uma chave pessoal basta clicar em  ‘Usuários’, na seção ‘Gerenciamento de acesso’, na coluna esquerda, ainda no serviço de IAM.<br>
<li>Clique no nome do usuário criado anteriormente.<br>
<li>Na página do usuário, abaixo da seção ‘Resumo’, clique na aba ‘Credenciais de segurança’. Em ‘Chaves de acesso’, clique em ‘Criar chave de acesso’.<br>
<li>Marque a opção ‘Command Line Interface (CLI)’ e, no fim da página, ‘Compreendo a recomendação acima e quero prosseguir para criar uma chave de acesso’. Clique em ‘Próximo’.<br>
<li>Defina uma etiqueta de descrição (opcional) e clique em ‘Criar chave de acesso’.<br>
<li>Armazene a ‘Chave de acesso’ e a ‘Chave de acesso secreta’, ou baixe o arquivo ‘.csv’ e clique em ‘Concluído’.<br>
<li>Para configurar a CLI com as credenciais de acesso à uma conta na AWS, digite <code>aws configure</code>, informando o ID e chave de acesso secreta vinculada a conta, o código da região que se pretende manipular os serviços e o formato do retorno dos dados (recomenda-se json).<br>
<li>O processo de execução de uma instância pode ser feito através do comando <code>aws ec2 run-instances --image-id ami-06a0cd9728546d178  --count 1 --instance-type t3.small --key-name nome_da_chave --block-device-mappings '[{"DeviceName":"/dev/xvda","Ebs":{"VolumeSize":16,"VolumeType":"gp2"}}]' --tag-specifications 'ResourceType=instance,Tags=[{Key="Name",Value="Teste"}]'</code>. O comando deve ser executado no diretório que contém o arquivo do par de chaves (nome_da_chave).<br>
</ol>

<h5>Gerar 1 elastic IP e anexar à instância EC2:</h5>
Este processo refere-se à geração de um IP elástico e sua associação à uma instância EC2, neste caso, realizado através da console web.
<ol>
  <li>No console web da AWS, através do menu 'Serviços', no canto superior esquerdo, acesse o serviço de 'EC2' (Elastic Compute Cloud). O termo 'EC2' também pode ser buscado através da barra de pesquisa, no topo da página.<br>
  <li>Na coluna esquerda, na sessão 'Redes e segurança', clique em 'IPs elásticos'.<br>
  <li>Clique no botão 'Alocar endereço IP elástico', marque a opção 'Conjunto de endereços IPv4 da Amazon' e clique em 'Alocar'. Pode ser necessário especificar o grupo de borda de rede que deve ser a mesma região onde foi criada a instância.<br>
  <li>Para associar o IP alocado à uma instância em execução selecione-o no painel de IPs, clique em 'Ações' e selecione a opção 'Associar endereço IP elástico'.<br>
  <li>Selecione 'Instância' no 'Tipo de recurso', escolha a instância que terá o IP associado e clique em 'Associar'.
</ol>

<h5>Liberar as portas de comunicação para acesso público:</h5>
Este processo refere-se à configuração de regras de entrada no grupo de segurança criado anteriormente, neste caso, realizado através da console web. As regras de segurança são: 22/TCP, 111/TCP e UDP, 2049/TCP/UDP, 80/TCP, 443/TCP.<br>
<ol>
  <li>No console web da AWS, através do menu 'Serviços', no canto superior esquerdo, acesse o serviço de 'EC2' (Elastic Compute Cloud). O termo 'EC2' também pode ser buscado através da barra de pesquisa, no topo da página.<br>
  <li>Na coluna esquerda, na seção 'Rede e segurança', clique em 'Security groups'.<br>
  <li>Selecione o grupo de segurança criado anteriormente, clique no botão 'Ações' e 'Editar regras de entrada'.<br>
  <li>Clique em 'Adicionar regra' ao inserir os dados de cada linha da tabela abaixo.<br>
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
   </table>
   <li>Após inseridas as 7 regras de entrada, clique em 'Salvar regras'.<br>
</ol>

<h5>Configurando um Network File System (NFS):</h5>
Este processo refere-se à criação de um NFS na instância EC2 criada anteriormente e a configuração de um diretório a ser compartilhado.<br>
<ol>
  <li>No terminal Linux, utilize o comando <code>mkdir /home/ec2-user/nfs/</code> para criar o diretório a ser compartilhado, nesse caso, localizado na pasta <code>/ec2-user</code>.<br>
  <li>Usando o comando <code>sudo yum update</code> atualize os pacotes instalados no sistema.<br>
  <li>A instalação dos pacotes referentes ao NFS podem ser incluídos no sistema via: <code>sudo yum install nfs-utils</code>.<br>
  <li>Para definir o diretório que será compartilhado, deve-se editar o arquivo <code>exports</code> no pasta <code>etc/</code> incluindo as informações: caminho_do_diretorio_compartilhado ip_da_instancia(rw,sync,no_subtree_check).<br>
  <li>Use o comando <code>sudo systemctl restart nfs-server</code> para reiniciar o serviço.<br>
  <li><code>systemctl status nfs</code> deve indicar que o serviço está ativo.<br>
  <li>Para conferir quais diretórios estão sendo compartilhados verifique o retorno do comando <code>sudo exportfs -v</code>.<br>
  <li>Por fim, para criar um diretório com o seu nome na pasta compartilhada, simplesmente execute o comando <code>mkdir /home/ec2-user/nfs/seu_nome/</code>.<br>
</ol>

<h5>Criando um servidor Apache:</h5>
Este processo refere-se à instalação de um servidor Apache na instância EC2 criada anteriormente.<br>
<ol>
  <li>No terminal Linux, execute o comando <code>sudo yum update</code> para atualizar os pacotes instalados no sistema.<br>
  <li>Instale os pacotes do Apache usando o comando <code>sudo yum install httpd</code>.<br>
  <li>Para iniciar o servidor digite <code>sudo systemctl start httpd</code>.<br>
  <li>Para verificar se o serviço está ativo utiliza-se o comando <code>systemctl status httpd</code>. O status deve estar ativo.<br>
  <li>Outra forma de verificar a disponibilidade do servidor é informando o endereço IP da instância na barra URL do navegador. Uma página de testes do Apache deve aparecer.<br>
</ol>

<h5>Script de verificação do status do serviço Apache:</h5>
Este processo refere-se à criação de um 'shell script' que tem a função de automatizar a verificação do status do serviço Apache gerado anteriormente.<br>
<ol>
  <li>O arquivo <code>apache_status.sh</code>, contido nesse repositório, tem a função de verificar o status do serviço <code>httpd</code>(Apache) e armazenar mensagens de log no diretório <code>/nfs</code>.<br>
  <li>O script possui a funcionalidade de criar os arquivos de log, caso ainda não existam, e adicionar a mensagem "Data-hora (fuso horário de São Paulo) + APACHE + ONLINE + SERVIDOR WEB ATIVO.", caso o serviço esteja ativo, e "Data-hora (fuso horário de São Paulo) + APACHE + OFFLINE + SERVIDOR WEB INATIVO.", caso contrário.<br>
</ol>
    
<h5>Preparar a execução automatizada do script a cada 5 minutos:</h5>
Este processo refere-se à execução automatizada do <code>apache_status.sh</code> a cada 5 minutos.<br>
<ol>
  <li>Execute o comando <code>crontab -e</code> para abrir, em modo de edição, o arquivo que armazena os scripts de automatização do sistema.<br>
  <li>Clique na letra <code>i</code> para ativar a função de inserção e adicione o comando: <code>*/5 * * * * /bin/bash caminho_do_script.sh</code>. Neste caso, o caminho do script é <code>/home/ec2-user/apache_status.sh</code>.<br>
  <li>Execute o comando <code>sudo systemctl restart crond</code>, para reiniciar o serviço de automatização. Agora o script <code>apache_status.sh</code> deve ser executado automaticamente a cada 5 minutos.<br>
</ol>
            
<h5>Instalação do linux em uma máquina virtual:</h5>
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
</ol>
