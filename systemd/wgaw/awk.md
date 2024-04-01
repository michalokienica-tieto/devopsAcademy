```bash
cat /etc/passwd | awk -F ":" '{print $1}' # users list

#shell list, unikalna i posortowana ;)
cat /etc/shells | awk -F "/" '/^\// {print $NF}' | uniq | sort 
# req exp - daszek i eskejpowany slash
# NF ???? nf - count args
echo "aa bb cc" | awk '{print NF}' # --> 3
cat /etc/shells | awk 'lenght($0) > 7'


df -h | awk '/\/dev\/loop/ {print $1"\t"$2"\t"$3}'

# BRUDNOPIS
cat /etc/passwd | awk -F ":" '{print $1" "$2"\t"$3}' 
ps | awk '{print $0}'

```