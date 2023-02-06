# Docker Commands

Hier die schnelle Übersicht der wichtigsten Docker-Befehle.

### Aktuelle Übersicht laufender *dockers*:
```bash
docker ps
```

### Stoppen von *docker*:
```bash
docker stop [container]
````

### (Re-)Build *docker* (nach Veränderungen an Files:
```bash
docker build -t kleer/methodenbot .
```

### Starting Docker:
```bash
docker run -it --rm kleer/methodenbot
```