#include <stdlib.h>

int	ft_numlen(long n)
{
	int	len;

	len = 0;
	if (n <= 0)
		len = 1;
	while (n != 0)
	{
		n = n / 10;
		len++;
	}
	return (len);
}

void	ft_fillstr(char *str, long nbr, int len)
{
	str[len] = '\0';
	if (nbr == 0)
		str[0] = '0';
	if (nbr < 0)
	{
		str[0] = '-';
		nbr = -nbr;
	}
	while (nbr > 0)
	{
		str[--len] = (nbr % 10) + '0';
		nbr = nbr / 10;
	}
}

char	*ft_itoa(int n)
{
	char	*result;
	long	nbr;
	int		len;

	nbr = (long)n;
	len = ft_numlen(nbr);
	result = (char *)malloc(sizeof(char) * (len + 1));
	if (!result)
		return (NULL);
	ft_fillstr(result, nbr, len);
	return (result);
}
