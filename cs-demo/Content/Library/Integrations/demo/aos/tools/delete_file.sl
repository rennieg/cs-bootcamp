namespace: Integrations.demo.aos.tools
flow:
  name: delete_file
  inputs:
    - host: 10.0.46.93
    - username: root
    - password: admin@123
    - filename: install_java.sh
  workflow:
    - ssh_command:
        do:
          io.cloudslang.base.ssh.ssh_command:
            - host: '${host}'
            - command: "${'cd '+get_sp('script_location')+' && rm -f '+filename}"
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      ssh_command:
        x: 68
        y: 89
        navigate:
          61add05a-f0fd-840f-5939-89da3a3cc1fc:
            targetId: 61295d57-918e-1353-a855-02305d544f84
            port: SUCCESS
            vertices:
              - x: 294
                y: 117
    results:
      SUCCESS:
        61295d57-918e-1353-a855-02305d544f84:
          x: 314
          y: 85
