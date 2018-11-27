# Crawler Estrada Real

Crawler que obtém os pontos de gps da estrada real disponível no site <a href="http://www.institutoestradareal.com.br/" target="_blank">http://www.institutoestradareal.com.br/</a>.
* Ruby version: ruby 2.0+

# Excutar o crawler

Antes de excutar o projeto instale todas as dependências com bundle install. A aplicação precisa de uma lista de links onde o crawler vai buscar os pontos de gps, título e descrição do local. Um exemplo de lista com os pontos do caminho dos diamantes está na pasta /lib.
O projeto possuí um executável que recebe dois parâmetros, o primeiro é o arquivo que contém os links das páginas e o segundo é caminho para salvar o arquivo de resultado da busca. Para rodar basta seguir o exemplo abaixo:
```bash
./bin/crawler_estrada_real.rb ./lib/links_points.txt resultado.csv
```

# Testes
Para rodar o testes basta excutar no terminal:
```bash
rake test
```

