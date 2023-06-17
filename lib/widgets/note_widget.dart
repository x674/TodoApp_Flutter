import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Model/note_model.dart';

class NoteWidget extends StatefulWidget {
  final Note note;
  final VoidCallback? onPressed;

  const NoteWidget(this.note, {Key? key, this.onPressed}) : super(key: key);

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Card(
        elevation: 0,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).colorScheme.outline),
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Text(widget.note.titleNote,
                  style: const TextStyle(
                      fontFamily: "Metropolis",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      letterSpacing: 0.1)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: Text(
                widget.note.textNote,
                style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.2),
              ),
            )
          ],
        ),
      ),
    );
  }
}
