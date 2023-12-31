import jenkins.model.*
import hudson.security.*
import hudson.model.FreeStyleProject
import hudson.tasks.*
import javaposse.jobdsl.plugin.*
import hudson.plugins.docker.registry.*
import jenkins.model.GlobalConfiguration
import hudson.plugins.git.GitTool

def jenkins = Jenkins.getInstance()
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
jenkins.setSecurityRealm(hudsonRealm)

def adminUsername = "admin"
def adminPassword = "admin"
hudsonRealm.createAccount(adminUsername, adminPassword)

def strategy = new GlobalMatrixAuthorizationStrategy()
strategy.add(Jenkins.ADMINISTER, adminUsername)
jenkins.setAuthorizationStrategy(strategy)

jenkins.save()