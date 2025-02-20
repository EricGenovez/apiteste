*** Settings ***
Library    RequestsLibrary
Library    String


*** Variables ***
${HOST}    https://dummyjson.com

# Rotas
${GET_ALL_PRODUCTS}    products

${GET_SINGLE_PRODUCT}    products/id-produto

${GET_SEARCH_PRODUCT}    products/search?q=busca



*** Keywords ***
Pegar todos os produtos
    
    &{headers}    Create Dictionary    Content-type=application/json
    GET    url=${HOST}/${GET_ALL_PRODUCTS}    headers=&{headers}    expected_status=200



Pegar um único produto de id ${id}
    &{headers}    Create Dictionary    Content-type=application/json

    ${GET_SINGLE_PRODUCT}=    Replace String    ${GET_SINGLE_PRODUCT}    id-produto    ${id}

    ${response}=    GET    url=${HOST}/${GET_SINGLE_PRODUCT}    headers=&{headers}
    [RETURN]   ${response}



Pegar um produto procurando ${produto}
    &{headers}    Create Dictionary    Content-type=application/json

    ${GET_SEARCH_PRODUCT}=    Replace String    ${GET_SEARCH_PRODUCT}    busca    ${produto}
    
    GET    url=${HOST}/${GET_SEARCH_PRODUCT}    headers=&{headers}


*** Test Cases ***
TC001 - Realizar Busca de todos os produtos
    Pegar todos os produtos

TC002 - Realizar Busco de um único produto
    ${response_keyword}    Pegar um único produto de id 1
    
    Should Be Equal As Strings    ${response_keyword.status_code}    200
    Should Be Equal As Strings    ${response_keyword.json()['title']}    Essence Mascara Lash Princess
    Should Be Equal As Strings    ${response_keyword.json()['price']}    9.99

    Log    ${response_keyword.json()}
    Log    ${response_keyword.json()["title"]}

TC003 - Realizar Busco de um produto especifico
    Pegar um produto procurando vehicle