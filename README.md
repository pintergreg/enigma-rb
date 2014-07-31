Enigma.rb
=========

Enigma cipher written in Ruby and Rails

The goal of this project was...
* to learn about Ruby on Rails,
* to learn about openShift,
* and of course to learn about Enigma. :)

Config to work on openShift
===========================

Replace the following line in app-root/repo/config/secrets.yml:

```
secret_key_base: <%=ENV['SECRET_KEY_BASE']%>
```
with:
```
secret_key_base: <%=ENV['OPENSHIFT_SECRET_TOKEN']%>
```

Push to openShift
=================
```
git remote add openshift ssh://<your ssh url>

git push --set-upstream openshift master
```

References
==========

* http://people.physik.hu-berlin.de/~palloks/js/enigma/enigma-u_v20_en.html [//]: # maybe the biggest help
* http://practicalcryptography.com/ciphers/enigma-cipher/ [//]: # very nice writing about how it works with example
* http://users.telenet.be/d.rijmenants/en/enigmatech.htm [//]: # very extensive site about enigma
* http://startpad.googlecode.com/hg/labs/js/enigma/enigma-sim.html 
* http://enigmaco.de/enigma/enigma.html [//]: # flash simulator in debug fashion
* http://www.matematiksider.dk/enigma_eng.html
* http://enigma.louisedade.co.uk/enigma.html [//]: # emulator and documentation
* http://en.wikipedia.org/wiki/Enigma_rotor_details [//]: # wiki about rotors

