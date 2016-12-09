find ../../docs/ -type f | xargs sed -i -e  "/<<<<<<< HEAD/,/=======/d" -e "/>>>>>>> mongodb\/master/d"
