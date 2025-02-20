*** Settings ***
Library    RequestsLibrary
Library    String

*** Variables ***
${HOST}    https://dummyjson.com

# Rotas
${ADD_NEW_PRODUCT}    products/add

*** Keywords ***
Adicionar um novo produto
    [Arguments]    ${title}    ${description}    ${price}    ${brand}
    &{headers}    Create Dictionary    Content-type=application/json

    &{body}    Create Dictionary    title=${title}   description=${description}   price=${price}   brand=${brand}

    POST    url=${HOST}/${ADD_NEW_PRODUCT}    headers=&{headers}    json=&{body}


*** Test Cases ***
TC001 - Realizar a adição de um novo produto
    Adicionar um novo produto    title=iphone 14    description=celular da apple    price=7000    brand=apple

