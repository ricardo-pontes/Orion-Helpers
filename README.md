# Orion-Helpers
Helper simples para TObject que auxilia na conversão de dados no formato JSON para Objeto e vice-versa

## Instalação

Para instalar basta registrar no library patch do delphi o caminho da pasta src da biblioteca ou utilizar o Boss (https://github.com/HashLoad/boss) para facilitar ainda mais, executando o comando

```
boss install https://github.com/ricardo-pontes/Orion-Helpers
```

## Como utilizar

É necessário adicionar ao uses do seu formulário a unit:

```
Orion.Helpers;
```
Após isso, os métodos em objetos estarão disponíveis para utilização.

### JSON para Objeto
Para carregar um JSON para o Objeto por exemplo, basta usar o método <b>FromJSON</b>.

```
Pessoa.FromJSON(aJSONObject);
```
O Método <b>FromJSON</b> aceita os tipos string, JSONObject e JSONArray(para utilizar em objetos do tipo TObjectList)

### Objeto para JSON
Para converter um Objeto Para JSON existem as seguintes opções;

```
JsonString := Pessoa.ToJSONString;
JsonObject := Pessoa.ToJSONObject;
JsonArray := Pessoas.ToJSONArray; //Pessoas aqui é do tipo TObjectList
```

### Objeto para Objeto
Também existe o método <b>FromObject</b>, que faz o carregamento de um objeto, desde que sejam do mesmo tipo;

```
var NovaPessoa := TPessoa.Create;
Pessoa.FromObject(NovaPessoa);
```

