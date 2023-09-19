# Projeto Calculadora - README

Este é o README do projeto Calculadora, que utiliza o Docker para facilitar a instalação, criação de imagens e criação de containers. Este projeto tem como objetivo demonstrar o uso básico do Docker no desenvolvimento de uma aplicação simples de calculadora.

## Instalação do Docker no Linux

Para instalar o Docker no Linux, siga as etapas abaixo:

1. Abra um terminal.

2. Verifique se o Docker já está instalado digitando o seguinte comando:

    ```bash
    docker --version
    ```

   Se o Docker já estiver instalado, a versão será exibida. Caso contrário, prossiga para a próxima etapa.

3. Use o gerenciador de pacotes do seu sistema operacional para instalar o Docker. Os comandos podem variar dependendo da distribuição Linux utilizada. Aqui estão alguns exemplos:

    - **Ubuntu**:

      ```bash
      sudo apt update
      sudo apt install docker.io
      ```

    - **Debian**:

      ```bash
      sudo apt update
      sudo apt install docker
      ```

    - **Fedora**:

      ```bash
      sudo dnf install docker
      ```

   Certifique-se de que o serviço Docker seja iniciado automaticamente no boot:

    ```bash
    sudo systemctl enable docker
    ```

4. Após a conclusão da instalação, verifique novamente a versão do Docker para confirmar que a instalação foi bem-sucedida:

    ```bash
    docker --version
    ```

   Agora o Docker está instalado no seu sistema Linux e você pode prosseguir com a criação de imagens e containers para o projeto Calculadora.

## Criação de Imagens e Containers

O Docker utiliza arquivos chamados Dockerfiles para definir a configuração e as dependências de uma imagem. O projeto Calculadora inclui um Dockerfile pré-configurado para facilitar a criação da imagem.

Siga as etapas abaixo para criar uma imagem e um container para o projeto Calculadora:

1. Clone o repositório do projeto para o seu ambiente de desenvolvimento.

2. Navegue até o diretório raiz do projeto Calculadora.

3. Crie a imagem Docker executando o seguinte comando:

    ```bash
    docker build -t calculator-image .
    ```

   Esse comando irá criar uma imagem chamada "calculadora" com base nas configurações definidas no Dockerfile.

4. Após a conclusão da criação da imagem, crie um container executando o seguinte comando:

    ```bash
    docker run -d --name calculadora-container -p 8080:8080 calculator-image
    ```

   Esse comando irá criar um container chamado "calculadora-container" a partir da imagem "calculadora" e mapeará a porta 8080 do container para a porta 8080 do seu sistema.

   Agora você pode acessar a aplicação Calculadora através do seu navegador, digitando "http://localhost:8080".

