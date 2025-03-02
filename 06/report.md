## Part 6. **GoAccess**


С помощью утилиты GoAccess получи ту же информацию, что и в [Части 5](#part-5-мониторинг).

Открой веб-интерфейс утилиты на локальной машине.

1. Установить goaccess:
```
sudo apt-get install goaccess
```
2. Сформировать html страницу и открыть ее:
```
goaccess ../04/*.log -o report.html --log-format=COMBINED
```
![](images/interface.png)


3. Отсортировать по кодам ответа:
![](images/sort_response_cod.png)

4. Все уникальные IP, встречающиеся в записях:
![](images/unique_ip.png)

5. Все запросы с ошибками (код ответа - 4хх или 5хх).
![](images/4xx_5xx.png)
