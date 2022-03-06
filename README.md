# Tex, do it!
A very simple shell script to compile latex formulas.

I recommend to copy the file in /bin directory, with 

```shell
wget https://raw.githubusercontent.com/caomem/texDoIt/master/texdoit.sh
chmod +x texdoit.sh
sudo cp texdoit.sh /usr/bin/texdoit
```

Then simply say: Tex, do it! 

```shell
texdoit "\frac{2}{2}" output.png
```

## ToDo list
1. [ ] List the dependeces in README
2. [ ] Create a install inscript (like JILL's installer script)
3. [ ] Create a -o option to auto open the file (xdg-open in linux, open in mac)
4. [ ] Create a -c option to auto copy the new file
