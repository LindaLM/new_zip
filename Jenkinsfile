pipeline {
    agent any
    
    parameters {
        string defaultValue: 'file.xml', description: 'Please enter the name of M file for this release', name: 'M', trim: true
        string defaultValue: 'file2.xml', description: 'Please enter the name of P_M filr for this release', name: 'P_M', trim: true
        string defaultValue: 'id', description: 'Please enter the A_ID for this release', name: 'A_ID', trim: true
        string defaultValue: 'v0.0.0', description: 'Please enter the R_VER for this release', name: 'R_VER',  trim: true
        booleanParam defaultValue: true, description: 'Please enter if you want D_N', name: 'D_N'
        booleanParam defaultValue: true, description: 'Please enter if you want D_C', name: 'D_C'
        booleanParam defaultValue: true, description: 'Please enter if you want D_D', name: 'D_D'
        booleanParam defaultValue: true, description: 'Please enter if you want to MERGE branches', name: 'MERGE'
        choice choices: ['w', 'q'], description: 'Please choose R_VAR', name: 'R_VAR'
        choice choices: ['0.1', '2.2'], description: 'Please choose LINE', name: 'LINE'
        booleanParam defaultValue: true, description: 'Please enter if you want TXT', name: 'TXT'
        booleanParam defaultValue: true, description: 'Please enter if you want B4K', name: 'B4K'
        gitParameter branchFilter: 'origin/(.*)', defaultValue: 'main', name: 'BRANCH', type: 'PT_BRANCH'
    }
    options {
        ansiColor('xterm')
    }
    environment {
        RED='\033[0;31m'
        GREEN='\033[0;32m'
        YEL='\033[0;33m'
        NC='\033[0m'
    }
    
    stages {
        stage("Clean Workspace") {
            steps {
                cleanWs()
                echo "${RED}Workspace cleaned ${NC}"
            }
        }
        stage("Prepare Workspace") {
            options { timeout(1) }
            steps {
                git branch: "${params.BRANCH}", 
                url: 'https://github.com/LindaLM/new_zip.git'
            }
        }
        stage ("Set") {
            steps {
                echo "${LINE}_${VERSION}"
                sh 'sleep 9s'
                echo "${RED}Set ${NC}"
            }
        }
        stage ("Build") {
            options { timeout(time: 3, unit: 'HOURS') }
            steps{
                echo "${RED}Build${NC}"
            }
        }
        stage ("Test 1") {
            options { timeout(time: 12, unit: 'SECONDS') }
            steps {
                echo "${RED}Testing ... ${NC}"
                sh 'sleep 10s'
                echo "${RED}Tested${NC}"
            }
        }
        stage("Analysis") {
            options { timeout(time: 3, unit: "HOURS") }
            steps {
                echo "${RED}Analysis done${NC}"
            }
        }
        stage("List"){
            options { timeout(time: 1, unit: "HOURS") }
            steps {
                echo "${RED}List generated${NC}"
            }
        }

        stage("Archive") {
            options{ timeout(time: 1, unit: "HOURS") }
            parallel {
                stage ("0.1") {
                    when {environment name: 'LINE', value: '0.1'}
                    steps {
                        echo "line = 0.1"
                        sh './zip_file.sh l_0.1.txt'
                        echo "${RED}archived${NC}"
                    }
                }
                stage ("2.2") {
                    when {environment name: 'LINE', value: '2.2'}
                    steps {
                        echo "line = 2.2"
                        sh './zip_file.sh l_2.2.txt'
                        echo "${RED}archived${NC}"
                    }
                }
            }
        }
        stage("Test 2") {
            options { timeout(time: 1, unit: "HOURS") }
            input {
                message "Please download and test zip and press PROCEED to continue: \n ${env.BUILD_URL}!"
            }
            steps {
                echo "${RED}Test 2 proceded${NC}"
            }
        }
        stage("Test 3") {
            options { timeout(time: 1, unit: "HOURS") }
            input {
                message "Please download and test zip and press PROCEED to continue: \n ${env.BUILD_URL}!"
            }
            steps {
                echo "${RED}Test 3 proceded${NC}"
            }
        }
        stage("D_N - S") {
            when {environment name: 'D_N', value: 'true'}
            options { timeout(time:1 , unit: "HOURS") }
            steps {
                echo "${RED}D_N - S${NC}"
            }
        }
        stage("D_N - A") {
            when {environment name: 'D_N', value: 'true'}
            options { timeout(time:1 , unit: "HOURS") }
            input {
                message "Acknowledge"
            }
            steps {
                echo "${RED}D_N acknowledged${NC}"
            }
        }
        stage("D_N - D") {
            when {environment name: 'D_N', value: 'true'}
            options { timeout(time:1 , unit: "HOURS") }
            steps {
                echo "${RED}D_N - D${NC}"
            }
        }
        stage("B4K") {
            when{ allOf { environment name: 'LINE', value: '2.2';
                            environment name: 'B4K', value: 'true'} }
            options { timeout(time: 3, unit: "HOURS")}
            steps {
                echo "${RED}B4K${NC}"
            }
        }
        stage("B4K - A") {
            when{ allOf { environment name: 'LINE', value: '2.2';
                            environment name: 'B4K', value: 'true'} } 
            options { timeout(time: 1, unit: "HOURS") }
            steps {
                echo "${RED}B4K - A${NC}"
            }
        }
        stage("B4K - N") {
            when{ allOf { environment name: 'LINE', value: '2.2';
                            environment name: 'B4K', value: 'true';
                            environment name: 'D_N', value: 'true'} } 
            options { timeout(time: 1, unit: "HOURS") }
            steps {
                echo "${RED}B4K - N${NC}"
            }
        }
        stage("Verification"){
            when { environment name: 'D_N', value: 'true'}
            options { timeout(time: 1, unit: "HOURS") }
            steps {
                echo "${RED}Verified${NC}"
            }
        }
    }
    post {
        aborted { echo "${RED}ABORTED${NC}"}
        changed { echo "${YEL}CHANDED${NC}"}
        failure { echo "${RED}FAILURE${NC}"}
        success { echo "${GREEN}SUCCESS${NC}"}
        unstable {echo "${YEL}UNSTABLE${NC}"}
    }
}
