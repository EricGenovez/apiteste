*** Settings ***
Library    RequestsLibrary
Library    String

*** Variables ***
${HOST}    https://dummyjson.com

# Rotas
${UPDATE_PRODUCT}    products/id-produto
${DELETE_PRODUCT}    products/id-produto-delete

*** Keywords ***
Atualizar um produto
    [Arguments]   ${id}    ${title}    ${description}    ${price}    ${brand}
    &{headers}    Create Dictionary    Content-type=application/json

    &{body}    Create Dictionary    title=${title}   description=${description}   price=${price}   brand=${brand}

    ${UPDATE_PRODUCT}=    Replace String    ${UPDATE_PRODUCT}    id-produto    ${id}

    PUT    url=${HOST}/${UPDATE_PRODUCT}    headers=&{headers}    json=&{body}

Deletar um produto de ${id}
    &{headers}    Create Dictionary    Content-type=application/json
    ${DELETE_PRODUCT}=    Replace String    ${DELETE_PRODUCT}    id-produto-delete    ${id}    

    ${response}    DELETE    url=${HOST}/${DELETE_PRODUCT}    headers=&{headers}   

    RETURN    ${response}

*** Test Cases ***
TC01 - Atualizar um produto
    Atualizar um produto  id=88     title=iphone 5c    description=celular da apple    price=300    brand=apple

TC02 - Deletar produto
    ${response}    Deletar um produto de 9

    Should Be True     ${response.json()["isDeleted"]} 
