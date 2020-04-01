getDay(DateTime day) {
    switch (day.weekday.toInt()) {
      case 1:
        return "Segunda";
        break;
      case 2:
        return "Terça";
        break;
      case 3:
        return "Quarta";
        break;
      case 4:
        return "Quinta";
        break;
      case 5:
        return "Sexta";
        break;
      case 6:
        return "Sábado";
        break;
      case 7:
        return "Domingo";
        break;
      default:
    }
  }