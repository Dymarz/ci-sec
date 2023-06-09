# Generated by Selenium IDE
require 'selenium-webdriver'
require 'json'
describe 'Register' do
  before(:each) do
    options = Selenium::WebDriver::Options.chrome
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-gpu')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--proxy-server=zap:8090')
    options.add_argument('--ignore-certificate-errors')
    @driver = Selenium::WebDriver.for :chrome, options: options
    @driver.manage.window.maximize
    @driver.manage.window.resize_to(6000,6000)
    @vars = {}
  end
  after(:each) do
    @driver.quit
  end
  it 'register' do
    @driver.get('http://juice_shop:3000/#/register')
    @driver.find_element(:id, 'emailControl').send_keys('user@mail.test')
    @driver.find_element(:id, 'passwordControl').send_keys('securepw')
    @driver.find_element(:id, 'repeatPasswordControl').send_keys('securepw')
    element = @driver.find_element(:css, '.ng-tns-c119-10 > .mat-form-field-infix')
    @driver.execute_script("arguments[0].click();", element)
    element = @driver.find_element(:css, '#mat-option-1 > .mat-option-text')
    @driver.execute_script("arguments[0].click();", element)
    element = @driver.find_element(:css, '.ng-tns-c119-12 > .mat-form-field-infix')
    @driver.execute_script("arguments[0].click();", element)
    @driver.find_element(:id, 'securityAnswerControl').send_keys('-')
    element = @driver.find_element(:id, 'registerButton')
    @driver.execute_script("arguments[0].click();", element)
    print("--- USER registered ---\n")
  end
end
