# -*- coding: utf-8 -*-
from seleniumbase import BaseCase


class RegisterWebGoat(BaseCase):

    def test_register_web_goat(self):
        print("Start testing registering")
        self.open('http://webgoat:8080/WebGoat/registration')
        print("Input username and password")
        self.update_text('#username', 'testuser')
        self.update_text('#password', 'testpw')
        print("Repeat password")
        self.update_text('#matchingPassword', 'testpw')
        self.click('[name="agree"]')
        self.click("//button[@type='submit']")
        print("Done!!!!!!")
