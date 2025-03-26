*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser    file://${CURDIR}/../swag_labs.html    firefox
Suite Teardown    Close Browser
Test Timeout      1 minute
Test Setup        Set Selenium Speed    0.1

*** Test Cases ***

Complete Shopping Flow
    [Documentation]    Test the full shopping experience from login to checkout
    
    # 1. Login to the application
    Input Text    id=username    standard_user
    Input Text    id=password    secret_sauce
    Click Button    id=login-button
    Wait Until Element Is Visible    id=product-page
    
    # 2. Add multiple items to the cart
    Execute JavaScript    window.scrollTo(0, 200)    # Scroll down a bit
    Click Button    xpath=(//button[text()='Add to Cart'])[1]    # First product
    Sleep    0.5    # Small delay to see the button change
    Click Button    xpath=(//button[text()='Add to Cart'])[2]    # Second product
    
    # Verify two items in cart
    Element Text Should Be    id=cart-count    2
    
    # 3. Proceed to checkout
    Click Element    class=cart-icon
    Wait Until Element Is Visible    id=checkout-page
    
    # 4. Remove one item from the cart
    Click Button    xpath=(//button[text()='Remove'])[1]
        
    # 5. Fill out the checkout form and complete purchase
    Input Text    id=first-name    John
    Input Text    id=last-name    Doe
    Input Text    id=postal-code    12345
    Click Button    xpath=//button[text()='Complete Purchase']
    
    # 6. Verify the success/confirmation message
    Wait Until Element Is Visible    id=confirmation-page
    Element Should Contain    id=confirmation-message    Thank you for your purchase
    
    [Teardown]    Close All Browsers