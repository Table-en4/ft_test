#include <unistd.h>

int	ato(char *str)
{
	int	i = 0;
	int	resul = 0;
	if (str[0] == '-')
		return (0);
	while (str[i])
	{
		if (str[i] >= '0' && str[i] <= '9')
			resul = resul * 10 + str[i] - '0';
		else
			return (0);
		i++;
	}
	return (resul);
}

void	num_hex(int num)
{
	char	hex[] = "0123456789abcdef";
	if (num >= 16)
		num_hex(num / 16);
	num = num % 16;
	write(1, &hex[num % 16], 1);
}

int	main(int ac, char **av)
{
	if (ac == 2)
		num_hex(ato(av[1]));
	write(1, "\n", 1);
}
