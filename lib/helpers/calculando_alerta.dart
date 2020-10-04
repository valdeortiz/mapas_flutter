part of 'helpers.dart';

void calculandoAlerta(BuildContext context) {
  if (Platform.isAndroid) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Espere por favor"),
              content: Text("Calculando Ruta"),
            ));
  } else {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Espera por favor"),
          content: CupertinoActivityIndicator(),
        );
      },
    );
  }
}
