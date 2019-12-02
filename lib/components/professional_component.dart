import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaners/Services/auth_service.dart';
import 'package:cleaners/Services/plannings_service.dart';
import 'package:cleaners/components/order_dialog.dart';
import 'package:cleaners/models/dto/planning_dto.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProfessionalComponent extends StatelessWidget {
  final PlanningDto planningDto;
  final SlidableController slidableController = SlidableController();
  final PlanningsService _planningsService = PlanningsService();
  final AuthService _authService = AuthService();

  ProfessionalComponent({@required this.planningDto});

  @override
  Widget build(BuildContext context) {
    var photo = planningDto.professional.picture == null
        ? AssetImage('assets/images/profile.png')
        : CachedNetworkImageProvider(planningDto.professional.picture);

    void createPlanning() {
      _planningsService.createPlanning(planningDto.planning).then((success) {
        String message = success
            ? 'Commande passée acess succès'
            : 'Oops, commande échouée...';
        IconData iconData =
            success ? Icons.check_circle_outline : Icons.error_outline;
        Color color = success ? Colors.green : Colors.red;
        Flushbar(
          message: message,
          icon: Icon(
            iconData,
            color: color,
          ),
          duration: Duration(seconds: 4),
          leftBarIndicatorColor: color,
        ).show(context);
      });
      Navigator.of(context).pop();
    }

    void showOrderConfirmation() {
      _authService.getLoggedInUser().then((user) {
        if (user != null) {
          showDialog(
            context: context,
            builder: (BuildContext context) => OrderDialog(
              planningDto: planningDto,
              onCreatePlanning: createPlanning,
            ),
          );
        } else {
          Flushbar(
            message: 'Vous devez vous connecter pour commander',
            icon: Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
            duration: Duration(seconds: 4),
            leftBarIndicatorColor: Colors.red,
          ).show(context);
        }
      });
    }

    return Slidable(
      key: Key('${planningDto.professional.id}'),
      controller: slidableController,
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      actions: <Widget>[
        IconSlideAction(
          closeOnTap: true,
          foregroundColor: Theme.of(context).accentColor,
          caption: 'Commander',
          color: Theme.of(context).primaryColor,
          icon: Icons.add,
          onTap: showOrderConfirmation,
        ),
      ],
      child: Container(
        color: Colors.white,
        child: ListTile(
          title: Text(
            '${planningDto.professional.lastName} ${planningDto.professional.firstName}',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          leading: CircleAvatar(
            backgroundImage: photo,
            maxRadius: 25.0,
          ),
          trailing: Chip(
            label: Text(
              '${planningDto.professional.price} €/h',
              style: TextStyle(color: Theme.of(context).accentColor, fontSize: 18.0),
            ),
            avatar: Icon(Icons.euro_symbol, color: Theme.of(context).accentColor,),
            shape: StadiumBorder(side: BorderSide()),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          subtitle: Text(
            'Subtitle here',
            style: TextStyle(color: Colors.black38),
          ),
        ),
      ),
      closeOnScroll: true,
    );
  }
}
