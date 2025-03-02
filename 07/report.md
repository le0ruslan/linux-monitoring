## Part 7. **Prometheus** и **Grafana**


* Установи и настрой **Prometheus** и **Grafana** на виртуальную машину.
![](images/version.png)
*  Получи доступ к веб-интерфейсам **Prometheus** и **Grafana** с локальной машины.
    * Prometheus<br>
![](images/prom-local.png)
    * Grafana<br>
![](images/graf-local.png)
* Добавь на дашборд **Grafana** отображение ЦПУ, доступной оперативной памяти, свободное место и кол-во операций ввода/вывода на жестком диске.<br>
![](images/simple-dashboard.png)
* Запусти свой bash-скрипт из Части 2
```
./main.sh az az.az 30Mb
```
* Посмотри на нагрузку жесткого диска (место на диске и операции чтения/записи).

    * Место на диске<br>
    ![](images/disk-memory-02.png)

    * Операции чтения/записи<br>
    ![](images/time-for-io-02.png)

* Установи утилиту **stress** и запусти команду
```
stress -c 2 -i 1 -m 1 --vm-bytes 32M -t 10s
```
* Посмотри на нагрузку жесткого диска, оперативной памяти и ЦПУ.
    
    * ЦПУ<br>
        ![](images/cpu-stress.png)
    
    * Оперативная память<br>
         ![](images/memory-ram-stress.png)

    * Операции чтения/записи<br>
         ![](images/time-for-io-stress.png)
    
    * Место на диске<br>
         ![](images/disk-memory-stress.png)       